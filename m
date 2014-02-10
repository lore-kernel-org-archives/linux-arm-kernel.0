From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:47:36 +0100
Subject: [PATCH 05/11] ARM: mvebu: add Device Tree for the Armada 375 DB
 board
In-Reply-To: <20140210173759.GB9995@lunn.ch>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173759.GB9995@lunn.ch>
Message-ID: <20140210184736.70af3774@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 10 Feb 2014 18:37:59 +0100, Andrew Lunn wrote:
> Hi Thomas
> 
> > +			mvsdio at d4000 {
> > +				pinctrl-0 = <&sdio_pins &sdio_st_pins>;
> > +				pinctrl-names = "default";
> > +				status = "okay";
> > +				cd-gpios = <&gpio1 12 0>;
> > +				wp-gpios = <&gpio1 13 0>;
> 
> Kirkwood recently started using include/dt-bindings/gpio/gpio.h. Maybe
> you can do the same here?

Sure, will do for the v2!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
