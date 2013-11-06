From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 12:49:37 +0100
Subject: [PATCH 10/13] ASoC: ux500_pcm: Extend Device Tree support to deal
 with DMA data
In-Reply-To: <1383732985-18928-11-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbk+3agGeKdQoEtazZf0Ui-iyykEooG+s+Do_amLyz9Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Soon we will strip out pdata support from the Ux500 set of ASoC drivers.
> When this happens it will have to supply a DMA slave_config to the
> dmaengine. At the moment a great deal of this comes from pdata via
> AUXDATA. We need to become independent of this soon. This patch starts
> the process by allocating memory for the associated data structures and
> fetches the MSP id used for const struct indexing.
>
> Cc: alsa-devel at alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
