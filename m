From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Jun 2013 10:07:59 -0400
Subject: [PATCH 7/8] arm: mvebu: add another earlyprintk Kconfig option
In-Reply-To: <20130605154749.29b51f40@skate>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130605134552.GK3803@titan.lakedaemon.net>
 <20130605154749.29b51f40@skate>
Message-ID: <20130605140759.GN3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:47:49PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 5 Jun 2013 09:45:52 -0400, Jason Cooper wrote:
> 
> > >  	config DEBUG_MVEBU_UART
> > 
> > Perhaps we should change this to DEBUG_MVEBU_UART_LEGACY?
> 
> > > +	config DEBUG_MVEBU_UART_ALTERNATE
> > 
> > And this to DEBUG_MVEBU_UART?
> 
> I'm fine with doing that, but it means that people who will keep their
> current .config that has CONFIG_DEBUG_MVEBU_UART=y will suddenly see
> their earlyprintk use 0xf1 instead of 0xd0. So in terms of kconfig
> backward compatibility, it's not the nicest thing, but if you believe
> that's ok, I'll change the patch as you proposed.

Very true.  I was purely looking at form.  Backwards compatibility is
definitely more important.

thx,

Jason.
