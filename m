From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Wed, 6 Apr 2011 11:40:24 +0200
Subject: [PATCH 4/6] ARM: mx3/mx31moboard: properly allocate memory for
	mx3-camera
In-Reply-To: <20110404150549.GC13963@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
	<201103070900.45258.philippe.retornaz@epfl.ch>
	<20110404150549.GC13963@pengutronix.de>
Message-ID: <201104061140.24617.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi, 4 avril 2011 17.05:49, Uwe Kleine-K?nig a ?crit :
> On Mon, Mar 07, 2011 at 09:00:45AM +0100, Philippe R?tornaz wrote:
> > Le vendredi, 4 mars 2011 21.51:20, Uwe Kleine-K?nig a ?crit :
> > > It's not allowed to create an alias of system RAM for DMA.  So the
> > > memory used must not be allocated using dma_alloc_coherent but has to
> > > be reserved before using memblock routines.
> > >
> > > There is no need to memzero the buffer because dma_alloc_coherent zeros
> > > the memory for us.
> > >
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> > Thank you very much for this patch !
> 
> Is this an Ack?
> 

Yes, I tested and it works fine. Thanks  !

Acked-by: Philippe Retornaz <philippe.retornaz@epfl.ch>

Regards,

Philippe
