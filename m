From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:46:17 +0200
Subject: [PATCH 8/9] mfd: db8500-prcmu: Return early if the TCPM cannot be
 located
In-Reply-To: <1364908916-29803-8-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQ0Zfd6vWisH-q1XcmPFqzQGtL8GzZpFyxbtGAoYT88A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently we check to see if we obtained the Tightly Coupled Program
> Memory (TCPM) base and only execute the code within the check if we
> have it. It's more traditional to return early if we don't have it.
> This way we can flatten most of the function's code down to a single
> tab spacing.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should go in through the MFD tree.

Yours,
Linus Walleij
