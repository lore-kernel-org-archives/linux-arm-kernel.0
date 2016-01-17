From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:23:37 +0100
Subject: [PATCH v3 4/9] ARM: dts: rockchip: enable the uart0 for kylin
 board
In-Reply-To: <1452865796-23527-5-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-5-git-send-email-wxt@rock-chips.com>
Message-ID: <3453769.45ZRnt7eYG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Januar 2016, 21:49:51 schrieb Caesar Wang:
> This patch is enabling the uart0 for bluetooth module.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6,

after moving your uart0 node _above_ the already existing uart2 node.


Heiko
