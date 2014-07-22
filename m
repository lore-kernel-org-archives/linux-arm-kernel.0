From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Tue, 22 Jul 2014 17:15:43 +0530
Subject: [PATCH 01/19] mfd: max77686: Fix 'line over 80 chars' warning
In-Reply-To: <1406027485-15657-2-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAMf-jSn4y40p+tpUNMnCMMmAEQbjXBqbfgPy3zWrTs_b85uvxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 4:41 PM, Lee Jones <lee.jones@linaro.org> wrote:
> This is part of an effort to clean-up the MFD subsystem.
>
<snip>
>         max77686->rtc_regmap = devm_regmap_init_i2c(max77686->rtc,
Which kernel are you on? Because 3.16.rc6 does not match with these
lines. Its something like this:
          'max77686->regmap = devm_regmap_init_i2c(i2c,
&max77686_regmap_config);'

Sorry if I am missing something.

> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks and Regards
Pramod
