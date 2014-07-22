From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Tue, 22 Jul 2014 17:57:52 +0530
Subject: [PATCH 01/19] mfd: max77686: Fix 'line over 80 chars' warning
In-Reply-To: <20140722121306.GB16065@lee--X1>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-2-git-send-email-lee.jones@linaro.org>
 <CAMf-jSn4y40p+tpUNMnCMMmAEQbjXBqbfgPy3zWrTs_b85uvxg@mail.gmail.com>
 <20140722121306.GB16065@lee--X1>
Message-ID: <CAMf-jSmyzMzucni8-Ego1K+-TvHm5S+HaY5OQKmR1QbjTNrOGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 5:43 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 22 Jul 2014, pramod gurav wrote:
>
> It's based on the most recent MFD for-mfd-next branch.
>
> You're missing the following patches:
>
>   mfd: max77686: Remove unneeded OOM error message
>   mfd: max77686: Make error checking consistent
>   mfd: max77686: Return correct error when pdata isn't found
>   mfd: max77686: Make platform data over-rule DT
>   mfd: max77686: Don't define dummy function if OF isn't enabled
>   mfd: max77686: Add power management support
>   mfd: max77686: Convert to use regmap_irq
>
ok. Thanks. :)

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



-- 
Thanks and Regards
Pramod
