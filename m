From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:19:42 +0800
Subject: [PATCH 22/22] mfd: Enable DT probing of the DB8500 PRCMU
In-Reply-To: <1338353260-10097-23-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-23-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYieu5BOR4c=nnGm4MLu26oYb0pLU2=UtgvEMH+=RdfaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch adds the correct compatible string for use during Device Tree
> population. Without it the DB8500 PRCMU will not be probed.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
