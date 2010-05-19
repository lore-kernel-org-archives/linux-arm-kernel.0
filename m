From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 18 May 2010 19:22:12 -0500
Subject: Known issues with amba-pl010.c driver?
Message-ID: <0D753D10438DA54287A00B0270842697636F1BC928@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Are there any known issues with the amba-pl010.c driver?

I have an application running on an ep93xx based system that uses one
of the serial ports to communicate with another board.  I am seeing
pauses while sending data from the ep93xx to the other board.

I see a similar pause when using one of the other serial ports as a
console.  When doing something that spews a lot of data to the port
the delays are very noticeable.  For instance the command:

/ # du

Spews the correct output but there are a number of pauses.

Both ports are running at a baud rate of 57600 if that matters.

Is there any way to debug this?

Thanks,
Hartley
