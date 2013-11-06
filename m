From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Nov 2013 11:22:48 +0000
Subject: [PATCH 06/13] ASoC: ux500_pcm: Extend ux500 MSP binding for
 enumeration
In-Reply-To: <20131106104658.GE11602@sirena.org.uk>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-7-git-send-email-lee.jones@linaro.org>
 <20131106104658.GE11602@sirena.org.uk>
Message-ID: <20131106112248.GE30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Nov 2013, Mark Brown wrote:

> On Wed, Nov 06, 2013 at 10:16:18AM +0000, Lee Jones wrote:
> 
> > +++ b/Documentation/devicetree/bindings/sound/ux500-msp.txt
> > @@ -3,6 +3,7 @@
> >  Required properties:
> >   - compatible       :"stericsson,ux500-msp-i2s"
> >   - reg              : Physical base address and length of the device's registers.
> > + - id               : MSP ID - used during component registration
> 
> I have no idea what this means or how one would pick the number?  It
> looks like something purely internal to the driver...

Hmm... yes I guess you're right. I think a match table would be more
appropriate.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
