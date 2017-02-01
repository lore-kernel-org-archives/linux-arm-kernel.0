From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2017 16:16:53 +0100
Subject: [PATCH 0/8] ADD STM32H743 MCU and STM32H743i-Eval board supports
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdb35JdbE5bPMU_NeVehnA-qs3aAxCgE0==L=Z9vmq1yWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 2:14 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This series adds basic support for STM32H743 MCU and stm32h743i-eval board.
> With it, you can boot stm32h743i-eval board successfully.

Patch 1 & 2 look fine to me.

Shall I just apply them and offer them on an immutable branch based
on v4.10 so you can pull that into ARM SoC if you want to get this in
for v4.11?

Yours,
Linus Walleij
