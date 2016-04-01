From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Apr 2016 13:42:19 +0200
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20160401114219.GG4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
>  create mode 100644 drivers/phy/sunxi/Kconfig
>  create mode 100644 drivers/phy/sunxi/Makefile
>  rename drivers/phy/{ => sunxi}/phy-sun4i-usb.c (100%)
>  rename drivers/phy/{ => sunxi}/phy-sun9i-usb.c (100%)

That would be allwinner in this case, sunxi is the SoC family
Allwinner produces.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160401/066e380c/attachment.sig>
