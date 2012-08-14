From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:20:36 +0200
Subject: [PATCH 4/8] ARM: ux500: Force AB8500 to use the GIC as its
 interrupt controller
In-Reply-To: <1344527635-6163-5-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbuXDAMF95V-X-rNdWnkm0maQFH1OM047=KdBrjm33duw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's understood that the AB8500 should be subordinate to the DB8500;
> however, the AB8500 uses the GIC as it's interrupt controller. If
> we do not specify which IRQ controller to use the default is to use
> the next encountered IRQ controller as we climb the tree. This would
> be the DB8500. This patch ensures the AB8500 makes use of the correct
> interrupt controller.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
