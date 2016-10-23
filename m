From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 01:55:23 +0200
Subject: [PATCH 1/2] pinctrl: stm32: remove dependency with interrupt
 controller
In-Reply-To: <1476970012-7838-2-git-send-email-alexandre.torgue@st.com>
References: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
 <1476970012-7838-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdZVDod=FVnNa1+Kqre8QdrmPwM8mM2YcioSgJDR5AT=Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 3:26 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This patch allows to probe stm32 pinctrl driver even if no interrupt
> controller is defined to manage gpio irqs.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
