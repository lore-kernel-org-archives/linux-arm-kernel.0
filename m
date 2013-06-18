From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jun 2013 11:14:02 +0200
Subject: [PATCH 0/3] ARM: ux500: mop500_snowball_ethernet_clock_enable()
 removal
In-Reply-To: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
References: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbpTMm8FG6KSwvq_7BQRGZ0P=PHHb+WikfRE6JqHv8xpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 10:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> As requested by you, this gets rid of  mop500_snowball_ethernet_clock_enable()
> which is no longer in use. It also straightens out a bug which ensures the
> SMSC911x's regulator is turned on at start-up when using Device Tree.
>
> This is based on your test-merge-20130615 branch.

All are Acked-by: Linus Walleij <linus.walleij@linaro.org>

I suggest the ARM SoC folks merge these three patches directly.
I've queued 1/3 and 2/3 on my devicetree branch so they won't
be lost, but 3/3 does not apply on any of my branches, it
needs to be applied directly on some ARM SoC baseline.

Yours,
Linus Walleij
