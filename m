From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 13:00:36 +0200
Subject: [PATCH 10/10] ARM: ux500: Stop informing the regulator subsystem
 that we have full constraints
In-Reply-To: <1349165603-24401-11-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-11-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYG_L3cxAo3BAkENTUoDx+HEDdHW8Ntv1ZdOqLJdFmfyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The regulator_has_full_constraints() call is not required if we
> are booting with Device Tree as it's assumed in this case.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
