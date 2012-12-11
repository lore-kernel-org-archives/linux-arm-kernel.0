From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Dec 2012 09:18:16 +0100
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and
 Armada XP
In-Reply-To: <20121211060050.GC25466@lunn.ch>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
 <20121210162819.46fe4f91@skate>
 <20121210214755.9CD823E0C7C@localhost>
 <20121210233723.1f3656d0@skate> <20121211060050.GC25466@lunn.ch>
Message-ID: <20121211091816.63e99769@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 11 Dec 2012 07:00:50 +0100, Andrew Lunn wrote:

> This is not actually true. Its dependent on at least one external
> component, a battery. The driver determines at load time if the clock
> is ticking.
> 
> There are a few Kirkwood and XP designs which use an external i2c RTC,
> because the battery recommended by Marvell is mechanically not so easy
> to attached to the board, in a robust way.
> 
> So i expect some boards will disable this from there own .dts file.
> However, defaulting to enabled would make sense.

Ok, thanks for the clarification!

Indeed, the OpenBlocks for example has a RTC on I2C, so maybe it'll
want to disable the on-SoC RTC.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
