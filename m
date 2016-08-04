From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2016 10:10:23 +0200
Subject: [PATCH] pinctrl: meson: Drop pinctrl_unregister for devm_
 registered device
In-Reply-To: <1469544718-32001-1-git-send-email-weiyj.lk@gmail.com>
References: <1469544718-32001-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <CACRpkdZutfsuRn9_QfsF6dzMWNyQp-Enic7MiibxkzV-dS24Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 4:51 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> It's not necessary to unregister pin controller device registered
> with devm_pinctrl_register() and using pinctrl_unregister() leads
> to a double free.
>
> This is detected by Coccinelle semantic patch.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Patch applied for fixes with Dmitry's and Kevin's tags.

Yours,
Linus Walleij
