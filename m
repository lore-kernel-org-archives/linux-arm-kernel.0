From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Jul 2011 16:26:19 +0900
Subject: [PATCH 1/7] DMA: PL330: Add support runtime PM for PL330 DMAC
In-Reply-To: <CAGOxZ50KGjHM6hUJQ1uEJsQqAzZ7aV+TcYRyhDB=sWQvtTDTxg@mail.gmail.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-2-git-send-email-kgene.kim@samsung.com>
	<CAGOxZ50KGjHM6hUJQ1uEJsQqAzZ7aV+TcYRyhDB=sWQvtTDTxg@mail.gmail.com>
Message-ID: <00c001cc3ae4$d82464c0$886d2e40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alim Akhtar wrote:
> > + ? ? ? /* enable dma clk */
> > + ? ? ? clk = clk_get(&adev->dev, "dma");
> 
> Does this really needed here?
> AFAIR, amba_get_enable_pclk() does the same thing, provided clock name
> as "apb_pclk"
> please have a look at drivers/amba/bus.c
> 
As I know, you can access Samsung datasheet, please check it.

Actually, the 'apb_pclk' should be dummy clock on current S5P SoCs so can't
use it now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
