From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Fri, 12 Sep 2014 00:27:15 -0700 (PDT)
Subject: [periperi] How to set default GPIO pin ?
In-Reply-To: <2862746.g5u9pdpKDi@avalon>
References: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
 <2862746.g5u9pdpKDi@avalon>
Message-ID: <874mwdmh7z.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent, Linus (Walleij)

Thank you for your help

> (Moving this thread to linux-sh and linux-arm and CC'ing Linus Walleij)
> 
> On Sunday 31 August 2014 22:08:52 Kuninori Morimoto wrote:
> > 
> > I know we can use "defalt" PFC settings on DT.
> > But, how to use "defalt" GPIO pin settings on DT ?
> > 
> > We would like to use GPIO 7-17 as Low output,
> > and do nothing after boot.
> 
> From a DT point of view I believe this is supposed to be done by specifying 
> the output-low or output-high properties in the pinctrl configuration node. 
> However, these properties are not supported by the PFC driver, and there's no 
> easy way for the PFC driver to configure GPIOs handled by a different driver 
> such as the gpio-rcar driver for instance.
> 
> Linus, do you have any hindsight on how this should be implemented ?

I'm happy if we can use this "defalt" GPIO on DT.
Linus, we need your opinion

Best regards
---
Kuninori Morimoto
