From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 22:48:15 -0800
Subject: [GIT PULL] ste_dma40 updates for 3.9
In-Reply-To: <20130114101542.GA5363@balto.lan>
References: <20130114101542.GA5363@balto.lan>
Message-ID: <CAOesGMg6FqsaqZiGeK14n4==dF-y=iMYSGRDBYSwkGWO0J69Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 2:15 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> Hello Arnd, Olof,
>
> This contains a series of updates and fixes for the ste_dma40 driver.
>
> The driver is specific for the ux500, and the patches were acked by both Linus
> Walleij, and Vinod Koul (dmaengine), who agreed to push this through arm-soc.
>
> Can you please pull those in for -next?

While I don't mind taking this through arm-soc, I don't see a strong
reason to do so?

This series of patches only modify the ste_dma40 driver, there are no
corresponding changes under arch/arm that need to be coordinated or
considered w.r.t. merge conflicts. I.e. they all seem nicely isolated
to only the driver.

So is there a specific reason for why these shouldn't just go in
through the dmaengine tree?


Thanks,

-Olof
