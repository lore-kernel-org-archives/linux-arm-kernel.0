From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 16:38:04 +0200
Subject: [PATCH -next] pinctrl: ns2: remove redundant dev_err call in
 ns2_pinmux_probe()
In-Reply-To: <1468333185-8047-1-git-send-email-weiyj_lk@163.com>
References: <1468333185-8047-1-git-send-email-weiyj_lk@163.com>
Message-ID: <CACRpkdakYUAVKyCygM4TKp4kb3pA8e4JoESLwySSSbW47cXisA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 4:19 PM,  <weiyj_lk@163.com> wrote:

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
