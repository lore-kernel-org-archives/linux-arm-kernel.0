From: j.courtoux@gmail.com (jo)
Date: Tue, 28 May 2013 14:19:21 +0200
Subject: In driver's A request_threaded_irq, call a driver's B irq_handler_t
 function.
Message-ID: <51A4A0C9.8080300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my project i need to call a driver name B when irq is wake up by 
driver A. So driver A is listening on GPIO and in probe 
request_threaded_irq. In this request_threaded_irq i need to call my 
specific function thread_fn which is in the driver A. Is it possible 
because I've try with pointers and other stuff but nothing work. On 
compile I've got error, or on my board driver doesn't work.
Driver work if all part of two driver are in one driver, but i need to 
use a generic driver A to use with driver B and in a near future a driver C.
