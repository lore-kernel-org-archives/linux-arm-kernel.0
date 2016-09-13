From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 10:12:23 +0200
Subject: [PATCH v5 5/9] Documentation: dt-bindings: Add IRQ related
 properties of STM32 pinctrl
In-Reply-To: <1473432124-6784-6-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-6-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdYJP59B7Qf0Q6017q5-81Bf-fJ_JTcyqG7XSEhh63CNjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 4:42 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied to the pinctrl tree.

I am happy with this solution.

As I see it, it doesn't hurt to add this into the pinctrl
tree while the irqchip stuff and DTS stuff get merged
into different trees orthogonally.

Yours,
Linus Walleij
