From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 10:48:54 +0200
Subject: [PATCH 08/22] gpio: syscon: Changing the compatibility string to
 match with the smallest supported chip
In-Reply-To: <1465024214-22120-9-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-9-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdZ7in+ORtTeJF1=hiC186wK+9kwpe9D9NPUXNiASJEc9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2016 at 9:10 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> This patch changes the compatibility string to match with the smallest
> supported chip (EP7209). Since the DT-support for this CPU is not yet
> announced, this change is safe.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
