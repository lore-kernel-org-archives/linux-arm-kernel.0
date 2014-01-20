From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 09:16:24 +0100
Subject: [PATCH v4 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <20140118025600.GS31049@beef>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-4-git-send-email-syin@broadcom.com>
 <CACRpkdaPZrR=kEknr3YKDWLd_E+o22Yn19ei7iT6cdbYdbeZ2w@mail.gmail.com>
 <52D98B99.5050604@broadcom.com> <20140118025600.GS31049@beef>
Message-ID: <CACRpkdYAANtY=9QtDnYNZLSrF09nTWUH4nK5oJ7mzznS+_=bHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 3:56 AM, Matt Porter <mporter@linaro.org> wrote:

> I wonder if Linus would accept a rename at this point (too late for 3.14
> presumably, but for 3.15) of s/capri/bcm281xx throughout, bcm11351 for
> the compatible string, as we have for the machine compatible, and also
> BCM281XX for the Kconfig option.

Yes, if there is some consensus that this is what we want to do.

I can certainly merge that during the 3.14-rc phase for that matter.

Yours,
Linus Walleij
