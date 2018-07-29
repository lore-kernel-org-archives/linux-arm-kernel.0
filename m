From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:02:44 +0200
Subject: [PATCH 1/2] pinctrl: stm32: fix bank io port number
In-Reply-To: <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdaO4-7ODpTo02mJjx167NH42QnFGj+hBRq3p=2-4j0iew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 2:57 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> In case the exti line is not in line with the bank number (that is the case
> when there is an hole between two banks, for example GPIOK and then GPIOZ),
> use "st,bank-ioport" DT property to get the right exti line.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
