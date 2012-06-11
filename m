From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 22:58:17 +0200
Subject: [PATCH 05/14] mfd: Enable DT probing of the DB8500 PRCMU
In-Reply-To: <1339428307-3850-6-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZzHctwtssvtE4HZv0H2mZwBMCYwVv+EA_n7CoV0iKNsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch adds the correct compatible string for use during Device Tree
> population. Without it the DB8500 PRCMU will not be probed.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
