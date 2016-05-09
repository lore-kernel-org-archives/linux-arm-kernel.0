From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 9 May 2016 20:53:15 +1000
Subject: next-20160503 build: 1 failures 12 warnings (next-20160503)
In-Reply-To: <2280495.M9rYajvqUJ@wuerfel>
References: <E1axZpG-000664-AK@optimist> <20160503141723.GR6292@sirena.org.uk>
 <2280495.M9rYajvqUJ@wuerfel>
Message-ID: <20160509205315.631e0c68@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and all,

On Tue, 03 May 2016 17:02:39 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tuesday 03 May 2016 15:17:23 Mark Brown wrote:
> > On Tue, May 03, 2016 at 01:53:18PM +0100, Build bot for Mark Brown wrote:
> > 
> > Today's -next fails to build an ARM allmodconfig due to:
> >   
> > >       arm-allmodconfig
> > > ../drivers/pinctrl/bcm/pinctrl-ns2-mux.c:540:17: error: 'pinctrl_utils_dt_free_map' undeclared here (not in a function)  
> > 
> > caused by b5aa1006e4a93 (pinctrl: ns2: add pinmux driver support for
> > Broadcom NS2 SoC) - presumably just a missing dependency.
> >   
> 
> No, the function got renamed in another patch. I already prepared a fix
> yesterday, but haven't gotten around to submit the patches for the last
> two days, I'll try to send it out today, but it might end up being
> tomorrow, or Linus could fix this one himself first.

Can we, please, get this fixed ... less than a week to the merge window
opening ...
-- 
Cheers,
Stephen Rothwell
