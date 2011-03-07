From: philippe.retornaz@epfl.ch (Philippe =?utf-8?q?R=C3=A9tornaz?=)
Date: Mon, 7 Mar 2011 09:00:45 +0100
Subject: [PATCH 4/6] ARM: mx3/mx31moboard: properly allocate memory for
	mx3-camera
In-Reply-To: <1299271882-2130-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
	<1299271882-2130-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201103070900.45258.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi, 4 mars 2011 21.51:20, Uwe Kleine-K?nig a ?crit :
> It's not allowed to create an alias of system RAM for DMA.  So the memory
> used must not be allocated using dma_alloc_coherent but has to be reserved
> before using memblock routines.
> 
> There is no need to memzero the buffer because dma_alloc_coherent zeros
> the memory for us.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thank you very much for this patch ! 

Regards,

Philippe
