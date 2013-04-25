From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:22:28 +0200
Subject: [PATCH 22/32] dmaengine: ste_dma40: Allocate plat_data on
 declaration
In-Reply-To: <1366279934-30761-23-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-23-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaeVN1Ou9zsiDHwv_o6RPEAs8LuYJ_yQafRwLPVS9wtww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's the way that most other drivers do it.
>
> Very trivial clean-up which reduces line count and simplifies code.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
