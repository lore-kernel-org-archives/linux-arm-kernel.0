From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 10:43:29 +0200
Subject: [DT Question] "simple-mfd" DT binding
In-Reply-To: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
References: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
Message-ID: <CACRpkdY88Zdp2zqabWPfYPnTwSzYuCqSQHQg9vF_+Zd=TFOvaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 3:29 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Because "simple-bus" indicates that child nodes are
> simply memory mapped, but the node "register-bit-led"
> can not be memory-mapped.
> So, "simple-mfd" can not be replaced "simple-bus" here.

Yeah... just like Lee points out, you are spot on, this is exactly
the reason why we created "simple-mfd" in the first place
IIRC.

Yours,
Linus Walleij
