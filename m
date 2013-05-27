From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:35:40 +0200
Subject: [PATCH 6/6] ARM: ux500: Enable support for UHS-I SD-cards
In-Reply-To: <1369314830-3727-7-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-7-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdaNLreLPfCRC6e=2kJ9NXMkNp_V_PEsirMFa+UvztHS5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> By setting the host capabilities MMC_CAP_UHS_SDR12|25 for
> the SD card device we enable support for UHS cards. The
> supported mode is SDR12 and SDR25.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied for ux500-core.

On the DT boot path this patch has the same problems
and comments as patches 3,4,5.

Yours,
Linus Walleij
