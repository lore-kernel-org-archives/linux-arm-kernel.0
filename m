From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:50:53 +0100
Subject: [PATCH 01/26] gpio: samsung: remove inclusion <mach/regs-clock.h>
In-Reply-To: <027701cdef62$12363bb0$36a2b310$@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
 <1357165443-3716-2-git-send-email-kgene.kim@samsung.com>
 <CACRpkdYhNHwqK3YkEKQedFvYDc6kuwesY4gmMroipnnhrLP6pA@mail.gmail.com>
 <027701cdef62$12363bb0$36a2b310$@samsung.com>
Message-ID: <CACRpkdYDa_vJhUZDJaO9N59ZscymcjD833pVC2rCz0tF9DmQ-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 7:41 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> BTW, do you have any comments on following patches?
>
> [PATCH] gpio: samsung: silent build warning for EXYNOS5
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14443.html

Merged to fixes.

> [PATCH] gpio: samsung: fix pinctrl condition for exynos and exynos5440
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/14758

Merged to fixes.

> [PATCH] gpio: samsung: skip gpio lib registration for EXYNOS5440
> http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/14673

I'll check it out, may have missed it.

Yours,
Linus Walleij
