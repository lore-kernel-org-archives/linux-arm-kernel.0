From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 9 Dec 2015 14:16:21 +0100
Subject: [PATCH v5 1/4] arm/arm64: add arm-smccc
In-Reply-To: <20151208150334.GD8644@n2100.arm.linux.org.uk>
References: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
 <1449581315-14519-2-git-send-email-jens.wiklander@linaro.org>
 <20151208150334.GD8644@n2100.arm.linux.org.uk>
Message-ID: <20151209131619.GA22755@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 03:03:34PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 08, 2015 at 02:28:32PM +0100, Jens Wiklander wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c24b6f7..8d5a7b0 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -2061,3 +2061,6 @@ config ASN1
> >  	  functions to call on what tags.
> >  
> >  source "kernel/Kconfig.locks"
> > +
> > +config HAVE_ARM_SMCCC
> > +	bool
> 
> I'm not sure why this has ended up in init/Kconfig - I suspect others
> will end up wondering the same.  arch/Kconfig looks to be a better
> place for it which is likely to be less controversial.  Please could
> you move it there?

Thanks, I'll fix.

/Jens
