From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 16 Sep 2013 02:49:06 +0000
Subject: [PATCHv4 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
In-Reply-To: <523392EA.6050909@wwwdotorg.org>
References: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
 <1379051922-4930-5-git-send-email-Li.Xiubo@freescale.com>
 <523392EA.6050909@wwwdotorg.org>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82833236@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +- fsl,pwm-counter-clk: The FTM PWM counter clock source, should be
> > +one of the
> > +  entries in clock-names.
> 
> So the IP block has 3 input clocks, and also a mux to select which one to
> use? That sounds slightly unusual, but possible.
> 
> If there is really only 1 clock input to the IP block, and the mux is
> part of some other module, then this binding should have only 1 entry in
> clocks.
> 

Yes, there are 3 input clocks that can be selectable, and the mux is inside the FTM IP block.


Thanks.

--
Best Regard,
Xiubo
