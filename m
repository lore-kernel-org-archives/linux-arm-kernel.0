From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Dec 2012 12:00:48 +0000
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
In-Reply-To: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201212131200.48413.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012, Maxime Ripard wrote:
> There is several different SoCs sharing the sun5i codename: A10s, A12
> and A13. Since there is enough differences to not consider those the
> same SoCs, change a bit the naming scheme to reflect this.
> 
> Moreover, some boards like the olinuxino come in A10s and A13 variants,
> which also share the same SoC codename.
> 
> So change the naming scheme to reflect both the codename and the market
> name of the SoCs used in the dtsi and in the board files
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Side note:
I just read about the A20 and A31, is there any information and/or
source code available for those already, or are they again kept
hidden by Allwinner?

	Arnd
