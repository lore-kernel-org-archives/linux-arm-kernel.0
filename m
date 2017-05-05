From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Fri, 5 May 2017 09:41:39 +0200
Subject: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
In-Reply-To: <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-3-ralph.sennhauser@gmail.com>
 <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
Message-ID: <20170505094139.484db2e7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Apr 2017 11:19:32 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
> 
> > From: Andrew Lunn <andrew@lunn.ch>
> >
> > Add properties to the GPIO nodes to allow them to be also used as
> > PWM lines.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > URL: https://patchwork.ozlabs.org/patch/427294/
> > [Ralph Sennhauser: Add new compatible string
> > marvell,armada-370-xp-gpio] Signed-off-by: Ralph Sennhauser
> > <ralph.sennhauser@gmail.com> Tested-by: Andrew Lunn
> > <andrew@lunn.ch>  
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please funnel this through ARM SoC.

Hi Gregory,

A reminder on the off chance you have missed this and it's not to late
already, Linus Walleij took the driver and submitted it for inclusion in
4.12 [1]. So for completeness it be nice to have the dts(i) and
defconfig changes in as well.

Thanks
Ralph

[1] https://lkml.org/lkml/2017/5/4/82

> 
> Yours,
> Linus Walleij
