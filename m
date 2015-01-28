From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 11:18:12 +0100
Subject: [PATCH V4 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
In-Reply-To: <1421658784-11980-3-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CABxcv=mCM63BobL+MP8LQhrh6HvtfromCouk2H6XdiFUm8ovmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To support SOCs which specifies specific MMC power sequences, document
> some MMC DT bindings to be able to describe these hardwares.
>
> Let's also document bindings for a simple MMC power sequence provider,
> which purpose is to support a set of common properties between various
> SOCs.
>
> In this initial step, let's also document a top level description of
> the MMC power sequence and describe the compatible string used for the
> simple MMC power sequence provider.
>
> The simple MMC power sequence provider will initially support a reset
> GPIO. From several earlier posted patches, it's clear that such
> hardware exists. Especially some WLAN chips which are attached to an
> SDIO interface may use a GPIO reset.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
