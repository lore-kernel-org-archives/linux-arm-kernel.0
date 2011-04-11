From: Richard.Russell@Honeywell.com (Russell, Richard S (G&N CoE))
Date: Mon, 11 Apr 2011 14:48:36 -0400
Subject: i.MX31 Early Kernel Messages
Message-ID: <352399F8DB39E14FBB4B648897CA32E60825A82A@DE08EV802.global.ds.honeywell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm having what appears to be a common (new user) problem.  When I boot
the kernel on the Logic PD i.MX31 SOM, kernel messages stop after the
"Uncompressing Linux... done, booting the kernel." message.

I've tried numerous versions of the kernel from various git repositories
(see list** below) and I've been unsuccessful using all of them.  I've
only been successful using the kernel from the "free" TimeSys board
support package.

As best I can tell, the TimeSys kernel sets up an early console to
display the early kernel messages. Is there an equivalent feature in the
latest kernel?  If so, how does one enable it?


**I've tried the latest versions of the kernel from:
   git://git.pengutronix.de/git/imx/linux-2.6.git
   http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git

Thanks,
Richard 
