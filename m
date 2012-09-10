From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Sep 2012 17:45:43 +0100
Subject: [PATCH 05/22] ASoC: Ux500: Enable MOP500 driver for Device Tree
In-Reply-To: <CACRpkdZ+zgEf48qpCRg_fz9=_oSGohuSsFLQoC3BzTgSDdNnZA@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ+zgEf48qpCRg_fz9=_oSGohuSsFLQoC3BzTgSDdNnZA@mail.gmail.com>
Message-ID: <20120910164542.GF24506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ola poke.

On Tue, Aug 14, 2012 at 10:52:23AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Here we ensure that the MOP500 audio driver will be probed during a
> > Device Tree boot. We also parse the sound node to link together the
> > codec, dma and the CPU-side Digital Audio Interface.
> >
> > CC: alsa-devel at alsa-project.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> But only if Mark agrees with the overall approach.
> 
> Yours,
> Linus Walleij

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
