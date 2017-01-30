From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 16:15:45 +0100
Subject: [PATCH 1/8] pinctrl: stm32: fix bad location of
 gpiochip_lock_as_irq
In-Reply-To: <1485533721-9019-2-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
 <1485533721-9019-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkda5ezDkN2rGOZLHepLJQu4qW9ZJ5W3s0APpvtp9SN6jGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 5:15 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> Move gpio lock as irq from "domain alloc" callback to "domain activate"
> callback. It will allow to use gpiolib sysfs correctly.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied.

Yours,
Linus Walleij
