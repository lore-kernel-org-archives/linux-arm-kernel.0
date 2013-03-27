From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Mar 2013 14:12:09 -0700
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <201303272205.17182@pali>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <201303241526.59275@pali> <20130327205606.GN10155@atomide.com>
 <201303272205.17182@pali>
Message-ID: <20130327211208.GQ10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130327 14:09]:
> On Wednesday 27 March 2013 21:56:07 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [130324 07:31]:
> > > it is possible to upstream errata 430973 workaround for
> > > RX-51?
> > 
> > I think we should make the SMC handling a generic function for
> > ARM.
> > 
> > AFAIK just the SMC call numbering is different for various
> > implementations. So the handler and passing of the parameters
> > seems like it should be generic.
> > 
> 
> Not only, look at freemangordon's email: 
> https://lkml.org/lkml/2013/3/1/62

Seem like you may need some SoC specific wrapper to the
generic function to deal with the params. But still seems
like we can have an ARM generic smc funtion.

Regards,

Tony
