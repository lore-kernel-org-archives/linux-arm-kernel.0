From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 04 Apr 2016 13:37:12 -0400
Subject: [PATCH 00/10] irqchip: lpc32xx: add LPC32xx irqchip driver
In-Reply-To: <loom.20160210T204046-649@post.gmane.org>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
 <loom.20160210T204046-649@post.gmane.org>
Message-ID: <1459791432.25564.15.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, 2016-02-10 at 19:45 +0000, Sylvain Lemieux wrote:
> Vladimir Zapolskiy <vz@...> writes:
> > 
> > The change adds wakeup controller platform driver and irqchip driver
> > for NXP LPC32xx boards.
>  
> Hi Vladimir,
> 
> Just to let you know that we did some testing using this changeset;
> I tested the change on 4.5-rc1 with patch 4 to 7, 10 & 11 from:
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/144671
> 
> I was able to run our software (I2C SIC1 interrupt enable)
> without any problem on a custom LPC32xx board.
> 
> > Vladimir Zapolskiy (10):
> >   dt-bindings: create arm/nxp folder and move LPC32xx SoC description to it
> >   dt-bindings: nxp: add description of wakeup controller on LPC32xx
> >   dt-bindings: interrupt-controllers: add description of SIC1 and SIC2
> >   arm: lpc32xx: add wakeup platform driver
> >   arm: dts: lpc32xx: assign interrupt types
> >   arm: dts: lpc32xx: add description of IC wakeup controllers
> >   arm: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC
> >   irqchip: add LPC32xx interrupt controller driver
> >   irqchip: lpc32xx: add option to wakeup from an interrupt
> >   arm: dts: lpc32xx: enable SIC1 and SIC2 by default
> 

As per the feedback you gave in the following message:
http://article.gmane.org/gmane.linux.ports.arm.kernel/483540

are you planning to send a version 2 of this patch for v4.7?

Sylvain Lemieux
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
