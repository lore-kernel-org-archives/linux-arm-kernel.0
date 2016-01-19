From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 19 Jan 2016 16:29:34 +0100
Subject: [PATCH v7 4/5] ARM: dts: rockchip: add rk3288 mipi_dsi nodes
In-Reply-To: <1452053038-32098-5-git-send-email-zyw@rock-chips.com>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
 <1452053038-32098-5-git-send-email-zyw@rock-chips.com>
Message-ID: <1528812.keQSB3ssvU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 6. Januar 2016, 12:03:56 schrieb Chris Zhong:
> Add a mipi_dsi node, and also add mipi_dsi endpoints to vopb and vopl
> output port nodes.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied to my dts32 branch for 4.6

after moving it to the correct position.
Please make sure to sort nodes by their register addresses in the future.


Thanks
Heiko
