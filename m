From: sricharan@codeaurora.org (Sricharan)
Date: Thu, 28 Jan 2016 10:57:51 +0530
Subject: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
In-Reply-To: <20160124113318.GB1775@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
 <20160124113318.GB1775@katana>
Message-ID: <001d01d1598c$a6dc1630$f4944290$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Wolfram Sang
> Sent: Sunday, January 24, 2016 5:03 PM
> To: Sricharan
> Cc: devicetree at vger.kernel.org; architt at codeaurora.org; linux-arm-
> msm at vger.kernel.org; ntelkar at codeaurora.org; agross at codeaurora.org;
> linux-kernel at vger.kernel.org; dmaengine at vger.kernel.org; linux-
> i2c at vger.kernel.org; iivanov at mm-sol.com; galak at codeaurora.org;
> andy.gross at linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
> 
> > > Sricharan R (6):
> > >   i2c: qup: Change qup_wait_writeready function to use for all
timeouts
> > >   i2c: qup: Add V2 tags support
> > >   i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
> > >   i2c: qup: Add bam dma capabilities
> > >   dts: msm8974: Add blsp2_bam dma node
> > >   dts: msm8974: Add dma channels for blsp2_i2c1 node
> > >
> >  Wolfram,  Does the first 4 patches looks good to be picked up  ?
> 
> Except for patch 3 (I replied seperately), the rest looks okay to me. I
> wondered a little if it would make sense to make a new driver for v2 +
DMA,
> because the additions were quite massive. But I'll leave it up to you if
there is
> enough shared code between the two versions, so that a single driver will
be
> better.
     Hmm,  addition of V2 reused code, more than 50% addition of new loc in
this series, lot of it from DMA,
     but at this point it feels ok to have it in a single driver. 

Regards,
 Sricharan
