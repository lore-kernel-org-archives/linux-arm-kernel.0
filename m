From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:14:28 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: add syscfg mask parameter
In-Reply-To: <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
 <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <CACRpkdb1OEQ+bsymueBTVwi+Qv8PYsxqipVWuLputdrhz_OgfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 11:56 AM Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> This parameter is needed if the mask is different of 0xf.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
