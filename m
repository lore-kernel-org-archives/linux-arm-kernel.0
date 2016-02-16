From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Tue, 16 Feb 2016 21:42:32 +0100
Subject: [PATCH] dmaengine: use phys_addr_t for slave configuration
In-Reply-To: <20160215173053.GM19598@localhost>
References: <1366967214-20776-1-git-send-email-linus.walleij@linaro.org>
 <CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
 <20150710081411.GF836@localhost>
 <CAMuHMdV8a1W1MyJPanUNBzaiNsL96JYzetBVSiZoC3=eKXzo1Q@mail.gmail.com>
 <20151215172649.GK1854@localhost>
 <CAMuHMdXe8i2JbhOP2sWkVkqHEeBnW4AfVBbRaoZW=Kg0s_9m3g@mail.gmail.com>
 <20160209225724.GA1522@katana> <20160215173053.GM19598@localhost>
Message-ID: <20160216204232.GB5268@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-02-15 23:00:53 +0530, Vinod Koul wrote:
> On Tue, Feb 09, 2016 at 11:57:24PM +0100, Wolfram Sang wrote:
> >
> > > This is a dependency for adding iommu support to the rcar-dmac driver, cfr.
> > > "[PATCH v2 0/5] dmaengine: rcar-dmac: add iommu support for slave transfers".
> > > http://www.spinics.net/lists/linux-renesas-soc/msg00066.html
> > > https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg00108.html
> > >
> > > Thank you for applying!
> >
> > Yup, we really need it. Anything we can do to help?
>
> I have done this change and discussing wider changes
> I will send CFT hopefully before EOW, pls test :)

Thanks Vinod for looking at this!
