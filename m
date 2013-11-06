From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 12:51:37 +0100
Subject: [PATCH 12/13] ASoC: ux500_pcm: Differentiate between pdata and DT
 initialisation
In-Reply-To: <1383732985-18928-13-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbsMhvKRB1BJBWO21BnDag1L9RkxskiVsck52piuGmnmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible request channel call
> back and, due to the work we laid down earlier in this patch-set, we
> can use core function calls to populate the DMA slave_config. We also
> require slightly different flags to inform the core that we 'are'
> booting with DT.
>
> Cc: alsa-devel at alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
