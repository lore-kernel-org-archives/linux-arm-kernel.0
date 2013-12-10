From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 10 Dec 2013 14:48:38 +0530
Subject: [TRIVIAL PATCH 1/2] regulator: s5m8767: Define symbol for buck
 control mask
In-Reply-To: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
References: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAK9yfHwz0Swi=vBu_Wynsr5ZDMDfwnFxS1p2Sc6ofabiotEa1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 10 December 2013 14:39, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:

>  static int s5m8767_reg_disable(struct regulator_dev *rdev)
>  {
>         struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
>         int ret, reg;
> -       int  mask = 0xc0, enable_ctrl;
> +       int mask = S5M8767_ENCTRL_MASK, enable_ctrl;

Couldn't we get rid of this mask variable here too?

Otherwise the patch looks good to me.

-- 
With warm regards,
Sachin
