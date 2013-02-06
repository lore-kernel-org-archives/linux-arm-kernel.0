From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 6 Feb 2013 10:08:35 +0800
Subject: [PATCH v2 00/10] rework pxa gpio driver for pinctrl
In-Reply-To: <CACRpkdbNZ4g-beSw=p3v7-QCtLO8sLg__XmhpPLvpvfqDnRLFw@mail.gmail.com>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbNZ4g-beSw=p3v7-QCtLO8sLg__XmhpPLvpvfqDnRLFw@mail.gmail.com>
Message-ID: <CAD6h2NSBaQ2SBiqUaxD+oTh9T_UnLKjcGjaqi8n=rts8mOmHmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2013 00:44, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Feb 3, 2013 at 11:15 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> v2:
>> * Fix the build issue without CONFIG_OF
>> * Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
>> * Use bool for inverted, ed_mask, gafr variable
>
> Haojian, does this series depend on the changes for DT in pinctrl-single,
> or can I merge it on its own?
>
> The amount of patches makes me confused you know ... :-)
>
> Yours,
> Linus Walleij

I'm waiting for Igor's test on PXA.
This patch series is used to support DT better. And the driver still works
without DT support since there's no DT in PXA chips.

Only the 9th & 10th patches are related to pinctrl-single driver. You could
skip them and I can move them into the pinctrl-single patch series.

Yes, these patches make people confusing. :) I'm sorry on inconvenience.

Regards
Haojian
