From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 17:30:50 -0500
Subject: [PATCH] ARM: Dove: move CuBox led pinctrl to gpio-leds node
In-Reply-To: <50F1DAE7.4050508@gmail.com>
References: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130112214257.GF13433@titan.lakedaemon.net>
 <50F1DAE7.4050508@gmail.com>
Message-ID: <20130112223050.GI13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 10:51:35PM +0100, Sebastian Hesselbarth wrote:
> On 01/12/2013 10:42 PM, Jason Cooper wrote:
> >On Thu, Dec 27, 2012 at 11:21:10PM +0100, Sebastian Hesselbarth wrote:
> >>gpio-leds has support for pinctrl allocation, make use of it.
> >>
> >>Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> >> ...
> >>  &pinctrl {
> >>-	pinctrl-0 =<&pmx_gpio_12&pmx_gpio_18>;
> >>+	pinctrl-0 =<&pmx_gpio_12>;
> >>  	pinctrl-names = "default";
> >>
> >>  	pmx_gpio_12: pmx-gpio-12 {
> >>--
> >>1.7.10.4
> >
> >I'm getting a merge conflict wit hthe above:
> >
> >&pinctrl {
> ><<<<<<<  HEAD
> >         pinctrl-0 =<&pmx_gpio_18>;
> >=======
> >         pinctrl-0 =<&pmx_gpio_12>;
> >>>>>>>>ARM: Dove: move CuBox led pinctrl to gpio-leds node
> >         pinctrl-names = "default";
> >
> >         pmx_gpio_18: pmx-gpio-18 {
> >                 marvell,pins = "mpp18";
> >                 marvell,function = "gpio";
> >         };
> >};
> >
> >Am I missing something?
> 
> Jason,
> 
> it depends on "ARM: Dove: move CuBox led pinctrl to gpio-leds node"
> that you applied to mvebu/fixes two days ago.

Ahhh, ok, I'll include it in this pull.

thx,

Jason.
