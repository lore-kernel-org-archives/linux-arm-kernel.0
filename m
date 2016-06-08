From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 10:44:45 +0200
Subject: [PATCH 07/22] gpio: clps711x: Changing the compatibility string
 to match with the smallest supported chip
In-Reply-To: <1465024214-22120-8-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-8-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdbeX_f_ich=9D17BgkSeRbi-TyGSuxVoszDwP0zCF8xJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2016 at 9:09 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> This patch changes the compatibility string to match with the smallest
> supported chip (EP7209). Since the DT-support for this CPU is not yet
> announced, this change is safe.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
