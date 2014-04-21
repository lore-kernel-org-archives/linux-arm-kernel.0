From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 21 Apr 2014 14:22:05 +0200
Subject: [PATCH] ARM: dts: at91-sama5d3_xplained: add the regulator
 device node
In-Reply-To: <20140421095443.GA3461@piout.net>
References: <1398054547-5834-1-git-send-email-wenyou.yang@atmel.com>
 <20140421095443.GA3461@piout.net>
Message-ID: <20140421122205.GB3461@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2014 at 11:54:43 +0200, Alexandre Belloni wrote :
> Hi,
> 
> On 21/04/2014 at 12:29:07 +0800, Wenyou Yang wrote :
> > +
> > +						vddana_reg: LDO_REG2 {
> > +							regulator-name = "VDDANA";
> > +							regulator-min-microvolt = <3300000>;
> > +							regulator-max-microvolt = <3300000>;
> > +							regulator-always-on;
> 
> I'm pretty sure that one is not always on as you actually have to
> configure it to get any voltage. Are you sure you want to set the
> regulator-always-on property here ?
> 

Just to clarify my though, wouldn't it be better to make the ADC driver
handle that regulator instead of using regulator-always-on ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
