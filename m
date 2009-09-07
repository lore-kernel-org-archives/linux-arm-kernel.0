From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Mon, 07 Sep 2009 19:04:18 +0900
Subject: [PATCH 12/12] [ARM][S3C6410] Add support gpio function for keypad
	device
In-Reply-To: <9c9fda240909061651y68dd8579r6cea25638ea120f1@mail.gmail.com>
References: <00ab01ca2e2d$1b52fcf0$51f8f6d0$%yang@samsung.com>
	<9c9fda240909061651y68dd8579r6cea25638ea120f1@mail.gmail.com>
Message-ID: <002101ca2fa2$9080fba0$b182f2e0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +
> > +       /* Set all the necessary GPK pins to special-function 0 */
> 
> special-function 3?

Sorry, my mistake

> 
> > +       for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
> > +               s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> > +               s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +       }
> > +
> > +       end = S3C64XX_GPL(0 + columns);
> > +
> > +       /* Set all the necessary GPK pins to special-function 0 */
> 
> ditto

Also mistake
