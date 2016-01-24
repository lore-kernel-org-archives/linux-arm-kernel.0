From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 24 Jan 2016 12:33:18 +0100
Subject: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
In-Reply-To: <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
Message-ID: <20160124113318.GB1775@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Sricharan R (6):
> >   i2c: qup: Change qup_wait_writeready function to use for all timeouts
> >   i2c: qup: Add V2 tags support
> >   i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
> >   i2c: qup: Add bam dma capabilities
> >   dts: msm8974: Add blsp2_bam dma node
> >   dts: msm8974: Add dma channels for blsp2_i2c1 node
> > 
>  Wolfram,  Does the first 4 patches looks good to be picked up  ?

Except for patch 3 (I replied seperately), the rest looks okay to me. I
wondered a little if it would make sense to make a new driver for v2 +
DMA, because the additions were quite massive. But I'll leave it up to
you if there is enough shared code between the two versions, so that a
single driver will be better.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160124/b18a0447/attachment.sig>
