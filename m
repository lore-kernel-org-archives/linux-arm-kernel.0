From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Dec 2013 17:47:00 +0100
Subject: Boot time errors/warnings on snowball
In-Reply-To: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
Message-ID: <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 5:37 PM, Olof Johansson <olof@lixom.net> wrote:

> I noticed these with last night's -next on the snowball:
>
> of_dma_request_slave_channel: dma-names property of node
> '/soc/msp at 80124000' missing or empty
> of_dma_request_slave_channel: dma-names property of node
> '/soc/msp at 80124000' missing or empty
> of_dma_request_slave_channel: dma-names property of node
> '/soc/msp at 80125000' missing or empty
> of_dma_request_slave_channel: dma-names property of node
> '/soc/msp at 80125000' missing or empty
> dma dma0chan22: [d40_config_memcpy] No memcpy
> dma dma0chan22: [d40_alloc_chan_resources] Failed to configure memcpy channel
> ux500-msp-i2s ux500-msp-i2s.1: Missing dma channel for stream: 0
> ux500-msp-i2s ux500-msp-i2s.1: ASoC: pcm constructor failed: -22

I don't see this when booting from the stuff I sent for v3.14,
but I know Mark applied some fixes from Lee yesterday,
Lee can you see if you recognize this?

Yours,
Linus Walleij
