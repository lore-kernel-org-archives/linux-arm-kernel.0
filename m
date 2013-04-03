From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:47:36 +0200
Subject: [PATCH 9/9] mfd: db8500-prcmu: Support platform dependant device
 selection
In-Reply-To: <1364908916-29803-9-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaRfBFMO+XnJVq9ccxsqw3+RS+OCPuF8ivrrRu=OxuJEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The main aim for this cycle is to have the u8540 booting to a
> console. However, the u8540 doesn't support all of the u8500
> platform devices yet. After this stage is complete we can then
> fill in the inadequacies, such as specific clock support at a
> later date. To achieve this we're placing devices supported by
> all platforms into a common device structure and the remaining
> ones into a platform specific one.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should also go through the MFD tree.

Yours,
Linus Walleij
