From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 11:46:08 +0100
Subject: [PATCH] Documentation: dt: list all compatible strings for at91
In-Reply-To: <5329727E.40604@atmel.com>
References: <1395224808-10133-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5329727E.40604@atmel.com>
Message-ID: <20140319104607.GM12021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2014 at 11:33:34 +0100, Nicolas Ferre wrote :
> On 19/03/2014 11:26, Alexandre Belloni :
> > Avoids getting the newly introduced warning:
> > WARNING: DT compatible string "atmel,at91sam9g45-adc" appears un-documented -- check ./Documentation/devicetree/bindings/
> > +				compatible = "atmel,at91sam9g45-adc";
> > 
> > Introduced by:
> > bff5da433525 checkpatch: add DT compatible string documentation checks
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Ok, if it is needed.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> BTW, I do not see the devicetree maintainers in the list of CC. If it is
> done for other architectures, I am fine with it, but if we are the only
> one to start this move, I would like them to be aware.
> 

Right, I'll resend.

Marvell is already listing all their compatibles but there is still the
issue for nvidia and fsl.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
