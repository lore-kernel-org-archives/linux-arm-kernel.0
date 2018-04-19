From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Thu, 19 Apr 2018 08:40:47 +0200
Subject: [PATCH v6 11/11] ARM: shmobile: Convert file to use cntvoff
In-Reply-To: <20180418134855.j3o7u3bxurnrsuay@verge.net.au>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-12-mylene.josserand@bootlin.com>
 <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
 <20180418120327.0f707abf@dell-desktop.home>
 <20180418134855.j3o7u3bxurnrsuay@verge.net.au>
Message-ID: <20180419084047.720e2976@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

On Wed, 18 Apr 2018 15:48:55 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Wed, Apr 18, 2018 at 12:03:27PM +0200, Myl?ne Josserand wrote:
> > Hello,
> > 
> > On Wed, 18 Apr 2018 11:36:27 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >   
> > > Hi Myl?ne,
> > > 
> > > On Mon, Apr 16, 2018 at 11:50 PM, Myl?ne Josserand
> > > <mylene.josserand@bootlin.com> wrote:  
> > > > Now that a common function is available for CNTVOFF's
> > > > initialization, let's convert shmobile-apmu code to use
> > > > this function.    
> > > 
> > > Thanks for your patch, works fine on Renesas ALT with R-Car E2,
> > > which suffers from lack of CNTVOFF initialization.  
> > 
> > Great to know that it works on this board.
> >   
> > >   
> > > > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>    
> > > 
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > Gr{oetje,eeting}s,
> > > 
> > >                         Geert
> > >   
> > 
> > Thank you again for testing it :)  
> 
> What is the plan for merging this patch/series?
> 
> I'd be happy to take this patch through the renesas tree once any
> dependencies are in place.

I will send a new series before the end of the week to correct the
reviews I got so far and I hope that the next one will be merged
(otherwise, I will fix what needs to be fixed, of course).

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
