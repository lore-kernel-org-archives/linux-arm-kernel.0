From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Jan 2013 10:41:12 -0800
Subject: [PATCH 01/26] gpio: samsung: remove inclusion <mach/regs-clock.h>
In-Reply-To: <CACRpkdYhNHwqK3YkEKQedFvYDc6kuwesY4gmMroipnnhrLP6pA@mail.gmail.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
 <1357165443-3716-2-git-send-email-kgene.kim@samsung.com>
 <CACRpkdYhNHwqK3YkEKQedFvYDc6kuwesY4gmMroipnnhrLP6pA@mail.gmail.com>
Message-ID: <027701cdef62$12363bb0$36a2b310$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Wed, Jan 2, 2013 at 11:23 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> 
> > The <mach/regs-clock.h> is not needed for gpio-samsung.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Applied to fixes, thanks.
> 
Thanks :-)

BTW, do you have any comments on following patches?

[PATCH] gpio: samsung: silent build warning for EXYNOS5
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14443.html

[PATCH] gpio: samsung: fix pinctrl condition for exynos and exynos5440
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/14758

[PATCH] gpio: samsung: skip gpio lib registration for EXYNOS5440
http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/14673

Any problems, please kindly let me know.

- Kukjin
