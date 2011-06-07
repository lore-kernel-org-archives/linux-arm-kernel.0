From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 7 Jun 2011 21:12:06 +0200
Subject: [RFC PATCH] KMS support for i.MX51/53
In-Reply-To: <20110607121701.71cdd06e@lxorguk.ukuu.org.uk>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
	<20110607121701.71cdd06e@lxorguk.ukuu.org.uk>
Message-ID: <20110607191205.GK23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 12:17:01PM +0100, Alan Cox wrote:
> > Currently I don't use any sophisticated memory allocater like GEM
> > or similar. I helped myself with simple dma_alloc where needed. At
> 
> GEM is actually pretty sane when you get your head around it a spot. The
> main thing it took me a bit of time to get my head around is that it
> allocates backing memory and handles but it doesn't allocate address
> space on the card side.

I'm not sure I understand you correctly. I have no address space on the
card side since my 'card' just uses main memory. The memory I need must
be a physically contiguous portion of sdram. I'm afraid shmem backing
memory is not of much use for me.

Correct me if I mix things up...

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
