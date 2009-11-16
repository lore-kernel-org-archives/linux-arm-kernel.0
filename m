From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Nov 2009 12:10:55 +0100
Subject: [PATCH] Update Samsung S5PC100 SoC support
In-Reply-To: <20091113235317.GY4808@trinity.fluff.org>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<20091113235317.GY4808@trinity.fluff.org>
Message-ID: <002101ca66ad$7a50a000$6ef1e000$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Saturday, November 14, 2009 12:53 AM Ben Dooks wrote:
 
> On Thu, Nov 12, 2009 at 09:21:44AM +0100, Marek Szyprowski wrote:
> > Hello,
> >
> > This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
> > core has been extended with new clocks hierarchy implementation, gpio lib,
> > support for external and gpio interrupts and some basics of power
> > management (cpu idle and system reset). Also platform helpers for
> > s3c framebuffer, i2c and hsmmc drivers has been added.
> 
> As such, a new branch git://git.fluff.org/bjdooks/linux next-s5pc1xx
> has been created. This branch hasn't yet been build tested, or had the
> patches that failed to apply on them.
> 
> The following from the series still need fixups before applying due to
> the missing FB updates:
> 
> Applying: ARM: S5PC1xx: add platform helpers for SDHCI host controllers
> Applying: ARM: S5PC1xx: add platform helpers for i2c adapter devices
> 
> I'll look at fixing these up tomorrow if the FB items haven't been sorted
> out.
> 
> The shortlog is:
> 
> Kyungmin Park (9):
>       ARM: SMDKC100: enable S3C FrameBuffer
>       ARM: S5PC1XX: registers rename
>       ARM: S5PC1XX: clock registers rename
>       ARM: S5PC1XX: clocks reimplementation
>       ARM: S5PC1XX: add GPIO L banks to register definition
>       ARM: S5PC1XX: GPIO registers rename
>       ARM: S5PC1XX: add cpu idle and system reset support
>       ARM: SMDKC100: add I2C0 and I2C1 buses support
>       ARM: SMDKC100: add SDHCI controllers 0, 1 and 2 support
> 
> If there are any problems, please let me know as soon as possible, as I
> will be looking to merge these into my main next branch in the next day or
> so to begin the final stages of the device and clock reworks.

This version does not compile without fb patches. I will send an updated
version (with your last remarks addressed) of the whole patch series soon.
Is there a chance you would accept that fb patch?

I'm really curious of the device and clock reworks. I hope you will manage
to get it working soon and prepare a pre-release version.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
