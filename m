From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Jul 2012 10:40:43 +0200
Subject: [PATCH 05/10] mmc: spi: Pull out the SSP clock configuration
 function
In-Reply-To: <20120718080755.cf7d4ac2e423278ce12843e6@kinali.ch>
References: <1342440597-8395-1-git-send-email-marex@denx.de>
 <201207172348.34919.marex@denx.de>
 <20120718080755.cf7d4ac2e423278ce12843e6@kinali.ch>
Message-ID: <201207181040.43467.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Attila Kinali,

> Good morning Marek,
> 
> On Tue, 17 Jul 2012 23:48:34 +0200
> 
> Marek Vasut <marex@denx.de> wrote:
> > > There is a EXPORT_SYMBOL_GPL(mxs_ssp_set_clk_rate); missing here.
> > 
> > What for?
> 
> To be able to compile mxs-mmc as a module

Argh, good point.

> 			Attila Kinali

Best regards,
Marek Vasut
