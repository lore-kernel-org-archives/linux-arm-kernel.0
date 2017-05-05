From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Fri, 5 May 2017 10:15:00 +0200
Subject: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
In-Reply-To: <87lgqb7mje.fsf@free-electrons.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-3-ralph.sennhauser@gmail.com>
 <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
 <20170505094139.484db2e7@gmail.com>
 <87lgqb7mje.fsf@free-electrons.com>
Message-ID: <20170505101500.170001a8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 05 May 2017 10:09:09 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Ralph,
>  
>  On ven., mai 05 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com>
> wrote:
> 
> > On Mon, 24 Apr 2017 11:19:32 +0200
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >  
> >> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> >> <ralph.sennhauser@gmail.com> wrote:
> >>   
> >> > From: Andrew Lunn <andrew@lunn.ch>
> >> >
> >> > Add properties to the GPIO nodes to allow them to be also used as
> >> > PWM lines.
> >> >
> >> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >> > URL: https://patchwork.ozlabs.org/patch/427294/
> >> > [Ralph Sennhauser: Add new compatible string
> >> > marvell,armada-370-xp-gpio] Signed-off-by: Ralph Sennhauser
> >> > <ralph.sennhauser@gmail.com> Tested-by: Andrew Lunn
> >> > <andrew@lunn.ch>    
> >> 
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >> 
> >> Please funnel this through ARM SoC.  
> >
> > Hi Gregory,
> >
> > A reminder on the off chance you have missed this and it's not to
> > late already, Linus Walleij took the driver and submitted it for
> > inclusion in 4.12 [1]. So for completeness it be nice to have the
> > dts(i) and defconfig changes in as well.  
> 
> Unfortunately it was too late to applied and to push it to arm-soc
> when the gpio part was applied.
> 
> So I will apply when 4.12-rc1 will be released and it will be
> included in the 4.13 release.

Such is life, thanks for the heads up.

Ralph

> 
> Gregory
> >
> > Thanks
> > Ralph
> >
> > [1] https://lkml.org/lkml/2017/5/4/82
> >  
> >> 
> >> Yours,
> >> Linus Walleij  
> >  
> 
