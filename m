From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 21:44:47 +0100
Subject: [PATCH 12/13] ARM: LPC32XX: architecture header files
In-Reply-To: <083DF309106F364B939360100EC290F805C8B787A9@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-13-git-send-email-wellsk40@gmail.com>
	<20100203170737.GN11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B787A9@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100203204447.GE20113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 08:20:01PM +0100, Kevin Wells wrote:
> > 
> > > +#define VMALLOC_END	(PAGE_OFFSET + 0x10000000)
> > grepping shows that defining VMALLOC_END based on PAGE_OFFSET is usual,
> > but I wonder why you don't just
> 
> The maximum addressable DRAM sizing is 256MB when fully populated. It seemed
> the right size. 0xF0000000 works too though, I have no problems changing it.
> 
> > 
> > 	#define VMALLOC_END 0xF0000000
> > 
The size of the vmalloc area has nothing to do with RAM.  See
http://www.arm.linux.org.uk/developer/memory.txt

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
