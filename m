From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Jan 2013 09:53:05 +0100
Subject: [GIT PULL] ste_dma40 updates for 3.9
In-Reply-To: <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
References: <20130114101542.GA5363@balto.lan>
 <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
Message-ID: <CACRpkdZh=5FBDCuSFWYw8t-1Snm1xuS_EyVTUyQ-8kwVgjWuPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 7:48 AM, Olof Johansson <olof@lixom.net> wrote:

> This series of patches only modify the ste_dma40 driver, there are no
> corresponding changes under arch/arm that need to be coordinated or
> considered w.r.t. merge conflicts. I.e. they all seem nicely isolated
> to only the driver.
>
> So is there a specific reason for why these shouldn't just go in
> through the dmaengine tree?

One reason would be if there are DMA bindings to device tree coming
this merge window, as I'm told, and it implicates a lot of platform code
changes on top of this as we adopt to it.

But maybe this will be wholly confined to the DMAengine tree?

Yours,
Linus Walleij
