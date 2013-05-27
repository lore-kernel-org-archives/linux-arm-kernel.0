From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:32:15 +0200
Subject: [PATCH 4/6] ARM: ux500: Enable support for discard for MMC/SD
In-Reply-To: <1369314830-3727-5-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <1369314830-3727-5-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdaCgdkrke7wxCCScMBkn7eOxSyTV0dEXzF7eiEqYaE6pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 3:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> By enabling MMC_CAP_ERASE for the SD/MMC devices the mmc block
> layer will now act on DISCARD requests.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied for ux500-core.

On the DT boot path this has the same problems and
comments as for patch 3: not supported on DT boots.

Yours,
Linus Walleij
