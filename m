From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jul 2016 09:55:35 +0200
Subject: [PATCH -next] pinctrl: nsp: remove redundant dev_err call in
 nsp_pinmux_probe()
In-Reply-To: <1467806571-23811-1-git-send-email-weiyj_lk@163.com>
References: <1467806571-23811-1-git-send-email-weiyj_lk@163.com>
Message-ID: <CACRpkdbcqjUFfThB_6mT0fYQca6VsLRAk1c1nTCEwptvPfqMjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 2:02 PM,  <weiyj_lk@163.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Patch applied with Ray's ACK.

Yours,
Linus Walleij
