From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 1 Feb 2013 06:09:44 -0300
Subject: [PATCH v3] arm: mvebu: support for the new Armada XP development
 board(DB-MV784MP-GP)
In-Reply-To: <1359643812-32654-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359643812-32654-1-git-send-email-gregory.clement@free-electrons.com>
 <1359643812-32654-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130201090943.GB10987@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 03:50:12PM +0100, Gregory CLEMENT wrote:
> This is the new Armada XP evaluation board from Marvell. It comes with
> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> Gigabit links.
> 
> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> when they become available for Armada XP in mainline.
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
> 

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Regards,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
