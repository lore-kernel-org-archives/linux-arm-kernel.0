From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 21:59:41 +0200
Subject: [PATCH 2/2] pinctrl: pinctrl-imx6q: add missed mux function for
 USBOTG_ID
In-Reply-To: <1341565763-10074-2-git-send-email-b29396@freescale.com>
References: <1341565763-10074-1-git-send-email-b29396@freescale.com>
 <1341565763-10074-2-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbUqR2y0b4cvsDfOjDYdPt7XhUsEG5JJGDyyzFB2JFjYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 11:09 AM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The original pin registers table is derived from u-boot mainline,
> but somehow it was found missing some mux functions for USBOTG_ID.
> We added it at the bottom by following the exist pin function ids,
> then it will not break the exist using of pin function id in dts file.
>
> Reported-by: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Applied.

Thanks!
Linus Walleij
