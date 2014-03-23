From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 23 Mar 2014 00:03:43 -0700
Subject: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
In-Reply-To: <1395543886.3460.95.camel@pasglop>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395543886.3460.95.camel@pasglop>
Message-ID: <20140323070343.GA17945@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 23, 2014 at 02:04:46PM +1100, Benjamin Herrenschmidt wrote:
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1594945..8122294 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -82,6 +82,7 @@ config ARM
> >  	  <http://www.arm.linux.org.uk/>.
> >  
> >  config ARM_HAS_SG_CHAIN
> > +	select ARCH_HAS_SG_CHAIN
> >  	bool
> >  
> 
> Heh, a self-selecting config option... I didn't know that trick !

ARM vs ARCH.  However the arm variant of the variable should probably be
consolidated into the ARCH one as a follow up.
