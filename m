From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:21:03 +0200
Subject: [PATCH 2/6] ARM: ux500: Don't set plf ocr mask for SD/MMC device
In-Reply-To: <1369314830-3727-3-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdahEueW1Wa6RgMgd48526Q-OkjmiqzW9SK_jF0b2NJGcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The mmci host driver overrides platform ocr mask when a vmmc regulator
> can be used. This is the case for sdi0(SD-card) and for sdi4(eMMC).
> Thus it is pointless of specifing these mask and why we do remove them.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This rids some boot noise as well, thanks!
Patch applied for ux500-core.

Yours,
Linus Walleij
