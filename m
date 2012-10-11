From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Oct 2012 16:20:40 +0200
Subject: [PATCH v2 00/15] pinctrl: samsung: Usability and extensibiltiy
 improvements
In-Reply-To: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
References: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdZEi85QjM9OH2zVet=E7whdc_cfCyOtdmumUio-ccrZ-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 10:11 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch series is a work on improving usability and extensibiltiy of
> the pinctrl-samsung driver. It consists of three main parts:
>  - improving flexibility of SoC-specific data specification
>  - converting the driver to one GPIO chip and IRQ domain per pin bank
>  - improving wake-up IRQ setup and handling

OK I managed to apply this series (I have a separate "samsung"
branch in the pinctrl tree now) and merged into for-next for some
testing in linux-next.

Applied Kyungmin's reviewed-by and Thomas' acked-by on all.

Thanks!
Linus Walleij
