From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 10 Apr 2012 15:44:51 +0200
Subject: [PATCH] ARM: mmci: add support for the Nomadik MMCI variant
In-Reply-To: <1334005410-20539-1-git-send-email-linus.walleij@linaro.org>
References: <1334005410-20539-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F843953.6070503@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 11:03 PM, Linus Walleij wrote:
> The Nomadik variant is somewhere inbetween the U300 and the Ux500
> variant, its actually expose the same primecell ID as the U300
> but had different characteristics so it needs a small revision
> bump and hard-coding from the board/device tree. After this it
> works just fine.
>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>

Looks good to me. Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
