From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 6 May 2014 11:32:50 +0200
Subject: [PATCH] i2c: nomadik: Don't use IS_ERR for devm_ioremap
In-Reply-To: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
References: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFo30t83UOvbPjH4DQ8JvvN-P290g_DdVq7hcu5cv+O0Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2014 16:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> devm_ioremap() returns NULL on error, not an error.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Linus, Wolfram - ping.

Kind regards
Ulf Hansson
