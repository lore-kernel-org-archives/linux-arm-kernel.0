From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:43:56 +0100
Subject: [PATCH v9 01/10] gpio: add gpio offset in gpio range cells
 property
In-Reply-To: <1361101376-3783-2-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZe97v4ecMWiCWJ=S7GGCi=de149PqXs25zy-1dQSp31g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add gpio offset into "gpio-range-cells" property. It's used to support
> sparse pinctrl range in gpio chip.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

OK I have applied this to the pinctrl tree for v3.10 to keep all pinctrl changes
together.

Thanks!
Linus Walleij
