From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Nov 2012 17:11:51 +0000 (UTC)
Subject: [PATCH v3 1/7] ARM: OMAP2xxx: hwmod: Convert SHAM crypto device
 data to hwmod
In-Reply-To: <20121109170703.GA13898@animalcreek.com>
References: <1352257033-32495-1-git-send-email-mgreer@animalcreek.com>
 <1352257033-32495-2-git-send-email-mgreer@animalcreek.com>
 <CALLzPKY7TCFe0yvpwJFNf8U2=h4k1Jcb8g9Q0UpGM8qv2FcSwg@mail.gmail.com>
 <20121109170703.GA13898@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1211091709000.20703@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Nov 2012, Mark A. Greer wrote:

> On Fri, Nov 09, 2012 at 06:10:20PM +0200, Kasatkin, Dmitry wrote:
>
> > Why not using macros as it was before?
> > 
> > OMAP24XX_SEC_SHA1MD5_BASE
> 
> I am following the precedent set in the existing code of that file
> which uses the actual address instead of a macro (except for uart).
> 
> I have no preference but I believe that is how Paul prefers it.
> 
> Paul?

My upstream prefers the raw addresses, I believe, under the rationale that 
it allows the macro definitions to be removed from arch/arm/mach-omap2.  
This reduces the total number of lines of code in that directory - and 
this is currently an overriding concern of my upstreams.

So, yes the address format in your patch is fine.


- Paul
