From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 9 Feb 2016 23:57:24 +0100
Subject: [PATCH] dmaengine: use phys_addr_t for slave configuration
In-Reply-To: <CAMuHMdXe8i2JbhOP2sWkVkqHEeBnW4AfVBbRaoZW=Kg0s_9m3g@mail.gmail.com>
References: <1366967214-20776-1-git-send-email-linus.walleij@linaro.org>
 <CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
 <20150710081411.GF836@localhost>
 <CAMuHMdV8a1W1MyJPanUNBzaiNsL96JYzetBVSiZoC3=eKXzo1Q@mail.gmail.com>
 <20151215172649.GK1854@localhost>
 <CAMuHMdXe8i2JbhOP2sWkVkqHEeBnW4AfVBbRaoZW=Kg0s_9m3g@mail.gmail.com>
Message-ID: <20160209225724.GA1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> This is a dependency for adding iommu support to the rcar-dmac driver, cfr.
> "[PATCH v2 0/5] dmaengine: rcar-dmac: add iommu support for slave transfers".
> http://www.spinics.net/lists/linux-renesas-soc/msg00066.html
> https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg00108.html
> 
> Thank you for applying!

Yup, we really need it. Anything we can do to help?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/1375b676/attachment.sig>
