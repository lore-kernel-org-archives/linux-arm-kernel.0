From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 24 Dec 2014 08:05:26 +0200
Subject: [PATCH 2/8] ARM: digicolor: add low level debug support
In-Reply-To: <2866303.axqKJidzX4@wuerfel>
References: <cover.1419318109.git.baruch@tkos.co.il>
 <d161e426125c28c9698fa5fecad4e5278abc0895.1419318109.git.baruch@tkos.co.il>
 <2866303.axqKJidzX4@wuerfel>
Message-ID: <20141224060525.GH2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Dec 23, 2014 at 10:00:17PM +0100, Arnd Bergmann wrote:
> On Tuesday 23 December 2014 09:58:39 Baruch Siach wrote:
> > @@ -14,5 +14,6 @@ static const char *digicolor_dt_compat[] __initconst = {
> >  };
> >  
> >  DT_MACHINE_START(DIGICOLOR, "Conexant Digicolor (Flattened Device Tree)")
> > +       .map_io         = debug_ll_io_init,
> >         .dt_compat      = digicolor_dt_compat,
> >  MACHINE_END
> 
> This change is not needed, the debug_ll_io_init function is used by default
> if no other map_io callback is specified.

OK. I'll remove it for next version.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
