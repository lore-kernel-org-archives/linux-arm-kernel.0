From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 16 Jun 2010 02:05:03 +0200
Subject: [PATCH 1/2] NUC900:  Add i2c0 driver support for NUC900
In-Reply-To: <20100615051905.GD3233@jasper.tkos.co.il>
References: <4C15143C.1020603@gmail.com>
	<20100615051905.GD3233@jasper.tkos.co.il>
Message-ID: <201006160205.04009.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 15. ?ervna 2010 07:19:05 Baruch Siach napsal(a):
> Hi Wan,
> 
> On Mon, Jun 14, 2010 at 01:24:12AM +0800, Wan ZongShun wrote:
> > This patch is to add i2c0 driver support for NUC900.
> > 
> > Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> > 
> > ---
> 
> [snip]
> 
> > +	pdata->get_clock(NULL, NULL, &apbclk_khz);
> 
> Why not use clk_get_rate() for this?
> 
> baruch

Other but what you already pointed out I can't find.

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
