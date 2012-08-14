From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:08:23 +0200
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The PCM is a pseudo-device. It doesn't have any of it's own registers
> or hardware. It rather acts as a layer of abstraction for DMA
> transfers. Hence, instead of classifying it as a device in its own
> right, we call the initialisation from the MSP driver.
>
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I'd prefer to have Ola LILJA review this patch, but it looks alright to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
