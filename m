From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 Mar 2013 18:27:02 +0100
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the
 timer 0
In-Reply-To: <CABx3TkU=y5_WTojbc9z17csaUh4PYxDUszdCdpWhmDM-JUEt5g@mail.gmail.com>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
 <CABx3TkU=y5_WTojbc9z17csaUh4PYxDUszdCdpWhmDM-JUEt5g@mail.gmail.com>
Message-ID: <20130320182702.3dc3fa20@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ryan Press,

On Wed, 20 Mar 2013 09:44:42 -0700, Ryan Press wrote:

> I can confirm this patch works for me as well.  I still have the
> problem on my Globalscale Mirabox where only a forced 10Mb link works
> on tx/rx.  With 100Mb only rx works, and 1Gb neither works.

Did you test both network interfaces? Do you have the problem on both?
I know there are issues on the Mirabox with the network interface that
wasn't initialized by U-Boot (i.e if you tftp your kernel from
interface 0, interface 0 works fine in Linux but not interface 1, if
your tftp your kernel from interface 1, it's the opposite).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
