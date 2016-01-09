From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 09 Jan 2016 03:39:45 +0100
Subject: [PATCH v2 02/12] ARM: dts: rockchip: add the sound codec for
 kylin board
In-Reply-To: <1452155155-16232-3-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-3-git-send-email-wxt@rock-chips.com>
Message-ID: <37250066.V9Rju7m7TL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 7. Januar 2016, 16:25:45 schrieb Caesar Wang:
> Support the rt5616 codec for kylin board, but we need
> enable the i2s firstly.
> Also, this patch adds the CPU/CODEC information for simple card
> to make the happy work.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts branch for 4.6.

I've adapted the commit message, to make it a bit more clear. [0]


Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.6-armsoc/dts32&id=1a21fe2a6f00226d126cd4ba4ac2484208c58b71
