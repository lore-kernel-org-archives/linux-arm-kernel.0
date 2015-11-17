From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 12:00:06 +0100
Subject: [PATCH v2 3/9] includes: dt-bindings: Add STM32F429 pinctrl DT
 bindings
In-Reply-To: <CALszF6B7928hpMDMH0_wmo-MakZX7sofO85aeBwv-aCLBHnrkA@mail.gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-4-git-send-email-mcoquelin.stm32@gmail.com>
 <56261239.5030007@linaro.org>
 <CALszF6DQ2G_Fzhk_SP+A0i_Z4mg9etdf1NcfQS3cPpB0zNot-w@mail.gmail.com>
 <CACRpkdashSEWL+KFgD+MmdoZwjXnsXpxy-MPmDciO9n87+6BBQ@mail.gmail.com>
 <CALszF6B7928hpMDMH0_wmo-MakZX7sofO85aeBwv-aCLBHnrkA@mail.gmail.com>
Message-ID: <CACRpkdZTHcROza2diFCOj783T1zfbkd=Dov3PUzDV2U35qEFXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 1:57 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> Thinking again at it, I persist to believe have the defines makes it
> easier to use.
> With auto-completion, it makes it faster and less error prone to
> select the right
> alternate function without parsing the datasheet.

Auto-completion ... should we design our source code to
fit certain editors?

> But as these defines are not actually used on driver side, maybe I
> could just move
> them to the dts directory?

No strong opinion there. include/dt-bindings is part of the bindings
documentation actually so I guess it goes there.

Yours,
Linus Walleij
