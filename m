From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 17:05:49 +0200
Subject: [PATCH 4/6] ARM: mx3/mx31moboard: properly allocate memory for
	mx3-camera
In-Reply-To: <201103070900.45258.philippe.retornaz@epfl.ch>
References: <20110304205008.GX22310@pengutronix.de>
	<1299271882-2130-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<201103070900.45258.philippe.retornaz@epfl.ch>
Message-ID: <20110404150549.GC13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 09:00:45AM +0100, Philippe R?tornaz wrote:
> Le vendredi, 4 mars 2011 21.51:20, Uwe Kleine-K?nig a ?crit :
> > It's not allowed to create an alias of system RAM for DMA.  So the memory
> > used must not be allocated using dma_alloc_coherent but has to be reserved
> > before using memblock routines.
> > 
> > There is no need to memzero the buffer because dma_alloc_coherent zeros
> > the memory for us.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Thank you very much for this patch ! 
Is this an Ack?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
