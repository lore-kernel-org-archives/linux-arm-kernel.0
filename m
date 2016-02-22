From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 22 Feb 2016 03:03:53 +0000
Subject: [PATCH v3 4/4] Documentation: atmel-pmc: add DT bindings for
 fast startup
In-Reply-To: <20160222025417.GH15973@rob-hp-laptop>
References: <1455507630-29592-1-git-send-email-wenyou.yang@atmel.com>
 <1455507630-29592-5-git-send-email-wenyou.yang@atmel.com>
 <20160222025417.GH15973@rob-hp-laptop>
Message-ID: <B256D81BAE5131468A838E5D7A243641D642649E@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 2016?2?22? 10:54
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Ferre, Nicolas <Nicolas.FERRE@atmel.com>; Alexandre Belloni
> <alexandre.belloni@free-electrons.com>; Jean-Christophe Plagniol-Villard
> <plagnioj@jcrosoft.com>; Russell King <linux@arm.linux.org.uk>; linux-
> clk at vger.kernel.org; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v3 4/4] Documentation: atmel-pmc: add DT bindings for fast
> startup
> 
> On Mon, Feb 15, 2016 at 11:40:30AM +0800, Wenyou Yang wrote:
> > Add DT bindings to configurate the PMC_FSMR and PMC_FSPR registers to
> > trigger a fast restart signal to PMC.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Document: binding
> >
> > ---
> >
> > Changes in v3:
> >  - update the property description.
> 
> This is not helpful. Assume I don't remember what I told you and you need to jog
> my memory what exactly changed so I don't have to go look it up.

Thank you for your instruction, I will keep it in mind.

> 
> >
> > Changes in v2:
> >  - change the property name and property description.
> >
> >  .../devicetree/bindings/arm/atmel-pmc.txt          |   63
> ++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thank you for your Acked.


Best Regards,
Wenyou Yang
