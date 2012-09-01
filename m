From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 02:23:48 +0200
Subject: [PATCH 2/2] ARM: allow for ATAGS to be configured out when DT
 support is selected
In-Reply-To: <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
References: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
 <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CACRpkdZqgjkOOfR7b9Fs8uixkDAnjj-VFmSfYQ_eN1-GuZtb+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 11:10 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:

> Now that ATAGS support is well contained, we can easily remove it from
> the kernel build if so desired.  It has to explicitly be disabled, and
> only when DT support is selected.

I patched this on top of my Integrator patch stack and disabled
the ATAGS, it just works.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

I'd suggest you to put this into Russells tracker then?

Yours,
Linus Walleij
