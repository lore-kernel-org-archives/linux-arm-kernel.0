From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 13:19:14 +0200
Subject: [PATCH] ARM: rockchip: select ARCH_DMA_ADDR_T_64BIT for LPAE
In-Reply-To: <1501581355-3538-1-git-send-email-huangtao@rock-chips.com>
References: <1501581355-3538-1-git-send-email-huangtao@rock-chips.com>
Message-ID: <1843978.TRc7q2v5pW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. August 2017, 17:55:55 CEST schrieb Tao Huang:
> Rockchip RK3288 has some 64-bit capable DMA and therefore needs
> dma_addr_t to be a 64-bit size. One user is the Mali GPU.
> 
> Signed-off-by: Tao Huang <huangtao@rock-chips.com>

applied for 4.14


Thanks
Heiko
