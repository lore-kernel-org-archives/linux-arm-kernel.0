From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Jan 2015 17:14:36 -0800
Subject: [GIT PULL] mvebu: dt for v3.20
In-Reply-To: <20150113145112.GC13100@lunn.ch>
References: <20150113145112.GC13100@lunn.ch>
Message-ID: <20150115011436.GD32756@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 03:51:12PM +0100, Andrew Lunn wrote:
> Hi Olof, Arnd
> 
> Here is the first dt pull request for mvebu for v3.20.
> 
>      Andrew
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.20
> 
> for you to fetch changes up to 928413bd859c0936f03f6a3504c4721e83a3d1d7:
> 
>   ARM: mvebu: Add Armada 388 General Purpose Development Board support (2015-01-09 09:20:00 -0600)
> 
> ----------------------------------------------------------------
> mvebu dt changes for v3.20 (part #1)
> 
> - Add Armada 388 General Purpose Development Board support
> - Add Device Tree description of the Armada 388 SoC
> - Document the Device Tree binding for the Armada 388 SoC
> - a38x: Add missing labels
> - a38x: Add more pinctrl functions
> - Add Armada 385 Access Point Development Board support
> - Add a number of pinctrl functions
> - A38x: Remove redundant pinctrl informations
> - a38x: Fix node names
> - Add support for Seagate BlackArmor NAS220
> - kirkwood: enable phy driver for SATA controller on 88f6192
> - gpio_poweroff support for Iomega ix2-200
> - Use all remaining MTD space foor rootfs of Iomega ix2-200
> 

Merged, thanks.

-Olof
