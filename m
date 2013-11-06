From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 12:50:29 +0100
Subject: [PATCH 11/13] ASoC: ux500: Store DMA data in the DAI differently
 in the pdata and DT case
In-Reply-To: <1383732985-18928-12-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZtsoLk6VaxPCFY8jZdrmxM9Q2Mz60QJ6+H_XNzMqKVYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In this patch we do two things. Firstly, instead of open coding the
> store of DMA data in to the DAI for later use, we use the API provided.
> Secondly we create and store similar DMA data for the DT case, only
> this time we use 'struct snd_dmaengine_dai_dma_data' which is provided
> by the core for this very reason.
>
> Cc: alsa-devel at alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
