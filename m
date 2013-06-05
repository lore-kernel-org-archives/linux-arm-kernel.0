From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Wed, 05 Jun 2013 23:00:26 +0900
Subject: [PATCH 05/10] mmc: dw_mmc-pltfm: remove static from
 dw_mci_pltfm_remove
In-Reply-To: <201306030058.27184.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030058.27184.heiko@sntech.de>
Message-ID: <001501ce61f5$08043ba0$180cb2e0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/13 2013 7:58 AM, Heiko St?bner wrote:
> dw_mci_pltfm_remove gets exported and used by dw_mmc-exynos, so should
> not be static.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
