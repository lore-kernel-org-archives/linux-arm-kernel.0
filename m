From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 11 Nov 2012 16:53:42 +0100
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <1352645834-10173-1-git-send-email-csd@broadcom.com>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
Message-ID: <12188358.5I1Xcz160E@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Sunday 11 November 2012 06:57:14 Christian Daudt wrote:
> In order to start upstreaming Broadcom SoC support, create
> a starting hierarchy, arch and dts files.
> The first support SoC family that is planned is the
> BCM281XX (BCM28145/28150/28155/28160) family of dual A9 mobile SoC cores
> This code is just the skeleton code for get the machine upstreamed. It
> has been made MULTIPLATFORM compatible.
> Next steps
> ----------
> Upstream a basic set of drivers - sufficient for a console boot to
> ramdisk. These will includer timer, gpio, i2c drivers.
> After this basic set, we will proceed with a more comprehensive set
> of drivers for the 281XX SoC family.

Would not it make more sense to use mach-bcm281xx as a directory name instead
of mach-bcm which sounds a tad too generic? This would also make it consistent
with Domenico's mach-bcm47xx and the existing bcm47xx and bcm63xx MIPS-based
SoC support.
-- 
Florian
