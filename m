From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 17:00:53 +0200
Subject: [PATCH] pinctrl: zynq: change error code for pinctrl_register
 failure
In-Reply-To: <20150526183734.GA31081@xsjsorenbubuntu>
References: <1432613909-13457-1-git-send-email-yamada.masahiro@socionext.com>
 <4437293.G26yCXqFQH@wuerfel>
 <20150526183734.GA31081@xsjsorenbubuntu>
Message-ID: <CACRpkdYU4MDP3dhVFvLgom36iwq_=dp8nQudO_t+mt9Kn7Dnow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 8:37 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Tue, 2015-05-26 at 10:12AM +0200, Arnd Bergmann wrote:

>> Could we add a pinctrl_register_reason() variant that returns a meaningful
>> error code as ERR_PTR?
>
> I agree with Arnd. As long as we don't get a precise error code we can
> just keep the current one.

pinctrl_register_cause() please.

Cause-and-effect, not "age of reason".

Yours,
Linus Walleij
