From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 22:29:45 -0800
Subject: [PATCH] ARM: sunxi: Change dtsi naming scheme for sun5i
In-Reply-To: <1355325915-22375-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355325915-22375-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121216062945.GA20881@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 04:25:15PM +0100, Maxime Ripard wrote:
> There is several different SoCs sharing the sun5i codename: A10s, A12
> and A13. Since there is enough differences to not consider those the
> same SoCs, change a bit the naming scheme to reflect this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Hi,

Applied in fixes for 3.8, since it makes sense to take care of the rename right
after introduction before it's out in a release with the other name.


-Olof
