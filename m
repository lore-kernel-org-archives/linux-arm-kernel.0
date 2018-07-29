From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:15:52 +0200
Subject: [PATCH 2/2] pinctrl: stm32: add syscfg mask parameter
In-Reply-To: <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
 <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
Message-ID: <CACRpkdbEnLh-SYK5vo5oUV9MnDQAiObcKdpqzTdPq2aj52VShQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 11:56 AM Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> To avoid backward compatibility, the drivers set
> the legacy value by default.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
