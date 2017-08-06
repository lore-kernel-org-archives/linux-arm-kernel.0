From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 17:41:56 +0200
Subject: [PATCH 1/2] arm64: dts: rockchip: Add support for rk3399 sapphire
 SOM
In-Reply-To: <1501756357-10511-1-git-send-email-jacob-chen@iotwrt.com>
References: <1501756357-10511-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <4583753.YODAZBW2BI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. August 2017, 18:32:36 CEST schrieb Jacob Chen:
> Add support for the rk3399 sapphire SOM board.
> This board works in a combination with the excavator main board.
> 
> You can get more info from below link:
> http://opensource.rock-chips.com/wiki_Excavator_sapphire_board
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>

applied for 4.14 with some property reordering and also replacing
the clkreqn pinctrl with the clkreqn_cpm pinctrl as clkreqn was removed
as nonworking, see

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=75ea96deec456c3e7aba375115ed530b425d5897
and
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=461a00bb9d539e0a78ad48e5c593f3d145f45c13

Please double check that I didn't break anything


Thanks
Heiko
