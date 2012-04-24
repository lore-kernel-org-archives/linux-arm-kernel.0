From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 10:07:41 +0200
Subject: [PATCH 12/15] mfd/db8500-prcmu: Register as a platform driver
 instead of only probing
In-Reply-To: <1334867804-31942-13-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZB5Hgdb1bGr3uxKYbJgQhatxMR2Pwf7f0NQa7c34gC-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Pass the probe function as part of the platform_driver struct and
> register using the more common platform_driver_register call. In
> subsequent patches we'll also add DT support into the struct.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Alternatively, if you get Sam's ACK I can carry this in the ux500 tree.

Yours,
Linus Walleij
