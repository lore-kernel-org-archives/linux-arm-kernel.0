From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 11:19:12 +0100
Subject: [PATCH V4 3/4] mmc: pwrseq: Initial support for the simple MMC
 power sequence provider
In-Reply-To: <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CABxcv=nPja4=8i2g=-BotHcmTbympZFuLMmaXzorNHPQjw=N1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To add the core part for the MMC power sequence, let's start by adding
> initial support for the simple MMC power sequence provider.
>
> In this initial step, the MMC power sequence node are fetched and the
> compatible string for the simple MMC power sequence provider are
> verified.
>
> At this point we don't parse the node for any properties, but instead
> that will be handled from following patches. Since there are no
> properties supported yet, let's just implement the ->alloc() and the
> ->free() callbacks.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
