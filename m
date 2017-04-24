From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:38:40 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: Set gpio controller also as
 interrupt controller
In-Reply-To: <1491577811-26989-5-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
 <1491577811-26989-5-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdYW94rkrK+Hpa-U_NyNw=zU1dToz5Za_K4RnP_oX5iFoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 5:10 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This patch set each gpio controller as a interrupt controller. User who
> wants to use gpio as interrupt will have choice to use either "gpiolib"
> interface or "common" interrupt interface.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
