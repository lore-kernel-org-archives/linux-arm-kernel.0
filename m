From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 4 Jul 2014 15:31:16 +0200
Subject: [PATCH v2 2/7] pwm: add support for atmel-hlcdc-pwm device
In-Reply-To: <539D6328.4020505@traphandler.com>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402329860-27520-3-git-send-email-boris.brezillon@free-electrons.com>
 <539D6328.4020505@traphandler.com>
Message-ID: <20140704153116.5fab1e1b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Jun 2014 11:11:04 +0200
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:


> >  
> > +config PWM_ATMEL_HLCDC_PWM
> > +	tristate "Atmel HLCDC PWM support"
> > +	depends on MFD_ATMEL_HLCDC
> I'd personnaly prefer a 'select' instead of 'depends on' here. Or maybe
> the MFD driver should enabled y defaut for platforms supporting the hlcdc.

After taking a closer look at other drivers, it seems most of sub
drivers "depends on" the MFD driver, so, unless other people complain
about that, I'll keep this definition.

Lee, any opinion on this point ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
