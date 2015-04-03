From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 20:21:38 +0200
Subject: [PATCH V2 1/3] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <CAL85gmD9qsjBdY2Qyv05AjutU_uad7aaRjxORk8om8WeRQM1Eg@mail.gmail.com>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
 <20150323183153.GA1128@katana>
 <CAL85gmD9qsjBdY2Qyv05AjutU_uad7aaRjxORk8om8WeRQM1Eg@mail.gmail.com>
Message-ID: <20150403182138.GB1298@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +     paddr = dma_map_single(ctx->dev, ctx->dma_buffer, readlen,
> >> +                            DMA_FROM_DEVICE);
> >
> > The device should be the device of the dma channel.
> 
> The device is not visible on linux, DMA is done by the helper processor.
> Perhaps you cah give me some idea how to do this. Thanks

Well, that is a question for the DMA maintainers. But we can fix this
later, I guess.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/d60dce7e/attachment.sig>
