From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 22:53:38 -0800
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
In-Reply-To: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121216065338.GB20881@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:08:23PM +0100, Maxime Ripard wrote:
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


Applied, replacing the previous version I claimed to have applied. ;)


-Olof
