From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 21 Nov 2010 03:19:34 +0100
Subject: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
In-Reply-To: <616676.83025.qm@web180301.mail.gq1.yahoo.com>
References: <20101120214820.GG8942@pengutronix.de>
	<616676.83025.qm@web180301.mail.gq1.yahoo.com>
Message-ID: <20101121021934.GH4216@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:59 Sat 20 Nov     , David Brownell wrote:
> 
> 
> --- On Sat, 11/20/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > > +??? ??? void
> > *nonconst_tx = (void *)xfer->tx_buf; /* shut up gcc */
> 
> Reads like a bad patch to me. Fix the bug,
> don't just silence GCC.  Or at least use
> a better comment mentioning a constness
> cast problems).

ok I change the comment

Best Regards,
J.
