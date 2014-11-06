From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Thu, 6 Nov 2014 11:41:48 -0500
Subject: [PATCH] ARM: dts: Add am57xx-beagle-x15
In-Reply-To: <1415290702-11353-1-git-send-email-nm@ti.com>
References: <1415290702-11353-1-git-send-email-nm@ti.com>
Message-ID: <20141106164148.GJ24112@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 10:18:22AM -0600, Nishanth Menon wrote:
> BeagleBoard-X15 is the next generation Open Source Hardware
> BeagleBoard based on TI's AM5728 SoC featuring dual core 1.5GHZ A15
> processor. The platform features 2GB DDR3L (w/dual 32bit busses),
> eSATA, 3 USB3.0 ports, integrated HDMI (1920x108 at 60), separate LCD
> port, video In port, 4GB eMMC, uSD, Analog audio in/out, dual 1G
> Ethernet.

Oh neat, you put a USB3 hub on the board?

I really should cleanup and submit my patch to make the system time not
run 576ppm too fast on the AM57xx.

This will sure be a nice board when you get it released.  I will have
to get one.

-- 
Len Sorensen
