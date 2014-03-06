From: marex@denx.de (Marek Vasut)
Date: Thu, 6 Mar 2014 16:33:31 +0100
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when
 possible
In-Reply-To: <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
Message-ID: <201403061633.31260.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 06, 2014 at 03:47:03 AM, Jingoo Han wrote:
> On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> (+cc Mohit KUMAR, Richard Zhu, Pratyush Anand, Marek Vasut,
>        Kishon Vijay Abraham I)
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> It works properly on Exynos platform.
> Thank you.

Looks reasonable,

Reviewed-by: Marek Vasut <marex@denx.de>

+CC Troy if he wants to test it on SL/N6X .

Best regards,
Marek Vasut
