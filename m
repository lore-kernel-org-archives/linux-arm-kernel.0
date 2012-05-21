From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:37:58 +0200
Subject: [PATCH 08/16] ARM: ux500: Allow PRCMU regulator to be probed
 during a DT enabled boot
In-Reply-To: <1337330355-17747-9-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb6pNF6Ge7p6L4Fs=OoBzBZSQzRp_hR9GyosiEJBPnEQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch adds the correct compatible string for use during Device Tree
> population. Without it the DB8500 PRCMU regulators would be processed
> when DT is enabled.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
