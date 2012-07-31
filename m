From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jul 2012 09:16:11 +0800
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <20120730142908.GM6802@n2100.arm.linux.org.uk>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <20120728133215.GG2128@S2101-09.ap.freescale.net>
 <5015624D.50305@googlemail.com>
 <20120730011426.GB30774@S2101-09.ap.freescale.net>
 <50162C7A.1060307@de.bosch.com>
 <20120730084558.GE31509@S2101-09.ap.freescale.net>
 <20120730142908.GM6802@n2100.arm.linux.org.uk>
Message-ID: <20120731011609.GE762@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:29:08PM +0100, Russell King - ARM Linux wrote:
> Don't do that.  CONFIG_ARCH_NR_GPIO is there so that we can consolidate
> out as much crap from mach/gpio.h as possible.  Either use it now, or I
> will patch you to make you use it.  Either way, you will end up using
> it... :)

Right.  I was wrong on that.  But I still maintain my position that
there is no much point to define CONFIG_ARCH_NR_GPIO as 224 for space
saving.  I would rather not use it for IMX until we have an IMX SoC
implementing more than 256 gpio.

-- 
Regards,
Shawn
