From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:52:23 +0200
Subject: [PATCH 05/22] ASoC: Ux500: Enable MOP500 driver for Device Tree
In-Reply-To: <1344527268-5964-6-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ+zgEf48qpCRg_fz9=_oSGohuSsFLQoC3BzTgSDdNnZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we ensure that the MOP500 audio driver will be probed during a
> Device Tree boot. We also parse the sound node to link together the
> codec, dma and the CPU-side Digital Audio Interface.
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

But only if Mark agrees with the overall approach.

Yours,
Linus Walleij
