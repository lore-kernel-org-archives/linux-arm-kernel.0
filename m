From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 17:44:01 +0100
Subject: [PATCH v2 00/10] rework pxa gpio driver for pinctrl
In-Reply-To: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbNZ4g-beSw=p3v7-QCtLO8sLg__XmhpPLvpvfqDnRLFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 3, 2013 at 11:15 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> v2:
> * Fix the build issue without CONFIG_OF
> * Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
> * Use bool for inverted, ed_mask, gafr variable

Haojian, does this series depend on the changes for DT in pinctrl-single,
or can I merge it on its own?

The amount of patches makes me confused you know ... :-)

Yours,
Linus Walleij
