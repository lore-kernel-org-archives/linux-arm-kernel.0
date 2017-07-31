From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Aug 2017 00:58:36 +0200
Subject: [PATCH] ARM: rockchip: enable ZONE_DMA for non 64-bit capable
 peripherals
In-Reply-To: <1501224002-9966-1-git-send-email-huangtao@rock-chips.com>
References: <1501224002-9966-1-git-send-email-huangtao@rock-chips.com>
Message-ID: <2708680.lC38ejFIoa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 28. Juli 2017, 14:40:02 CEST schrieb Tao Huang:
> Most IP cores on ARM Rockchip platforms can only address 32 bits of
> physical memory for DMA. Thus ZONE_DMA should be enabled when LPAE
> is activated.
> 
> Signed-off-by: Tao Huang <huangtao@rock-chips.com>

applied for 4.14


Thanks
Heiko
