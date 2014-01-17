From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jan 2014 00:12:36 +0100
Subject: [PATCH] pinctrl: capri: add dependency on OF
In-Reply-To: <52D989C2.6030603@broadcom.com>
References: <1389912312-16285-1-git-send-email-linus.walleij@linaro.org>
 <52D989C2.6030603@broadcom.com>
Message-ID: <CACRpkdYVLF+CNcAc8=MiSRJJMBWy3LriDw271Bx=gjuuzdOatA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 8:51 PM, Sherman Yin <syin@broadcom.com> wrote:

> Thanks for the fix, Linus.  While we're visiting this config, should we add
> "depends on MACH_BCM_MOBILE" as well?

No, it's nice to get the compile coverage.

Yours,
Linus Walleij
