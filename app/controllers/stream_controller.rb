class StreamController < ApplicationController
  include ActionController::Live

  def live
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate

    sse = SSE.new(response.stream, retry: 300, event: 'Stream Started')
    puts 'Stream Started'

    sleep 1

    sse.write("The current time is #{Time.current}", event: "Current time")
  rescue ActionController::Live::ClientDisconnected
    logger.info 'ClientDisconnected'
    sse.close
    response.stream.close
  rescue IOError
    logger.info 'IOError'
    sse.close
    response.stream.close
  ensure
    sse.close
    response.stream.close
  end
end
