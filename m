From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:22:23 +0200
Subject: [PATCH 2/4] pinctrl: stm32: replace device_initcall() with
 arch_initcall()
In-Reply-To: <1491577811-26989-3-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
 <1491577811-26989-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdaVeoi-U9Ra9PPASpKsSyd2AC+vfB5wOobu8ur0oPEswg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 5:10 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> Pinctrl has to be registered earlier. Mainly to register bank irqdomain
> earlier as other devices could use interrupts from those irqdomain.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Yeah I also see that a lot. I guess workarounds like this is
necessary.

Patch applied.

Yours,
Linus Walleij
