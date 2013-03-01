From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 14:00:31 +0100
Subject: [PATCH v9 08/10] pinctrl: single: set function mask as optional
In-Reply-To: <1361101376-3783-9-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZD8D+ssx0ZrhhEYmmpSq-hUDDpOnP9=p6eHqxMMbBrSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since Hisilicon's pin controller is divided into two parts. One is the
> function mux, and the other is pin configuration. These two parts are
> in the different memory regions. So make pinctrl-single,function-mask
> as optional property. Then we can define pingroups without valid
> function mux that is only used for pin configuration.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch applied!

Thanks,
Linus Walleij
