From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 24 Feb 2016 19:17:27 +0100
Subject: [PATCH v9 0/2] power: act8945a: add charger driver for the
 sub-device of ACT8945A MFD
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D6428FF2@penmbx01>
References: <1455524524-9359-1-git-send-email-wenyou.yang@atmel.com>
 <B256D81BAE5131468A838E5D7A243641D6428FF2@penmbx01>
Message-ID: <20160224181727.GA19106@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 24, 2016 at 09:33:13AM +0000, Yang, Wenyou wrote:
> > -----Original Message-----
> > From: Wenyou Yang [mailto:wenyou.yang at atmel.com]
> > Sent: 2016?2?15? 16:22
> > To: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
> > <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Rob
> > Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> > <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> > Gala <galak@codeaurora.org>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>; Javier Martinez Canillas
> > <javier@dowhile0.org>; Lee Jones <lee.jones@linaro.org>; Peter Korsgaard
> > <jacmet@gmail.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> > pm at vger.kernel.org; Yang, Wenyou <Wenyou.Yang@atmel.com>
> > Subject: [PATCH v9 0/2] power: act8945a: add charger driver for the sub-device
> > of ACT8945A MFD
> > 
> > The ACT8945A is a Multi Function Device with the following subdevices:
> >  - Regulator
> >  - Charger
> 
> I would like to know if this patch set is okay to apply.
> Or any comments?

No comments, I just queued it with "|| COMPILE_TEST" dependency
added.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/9d0d7c5a/attachment.sig>
