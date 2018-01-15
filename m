From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jan 2018 02:07:24 +0100
Subject: [PATCH 03/14] mmc: mmci: Add support for setting pad type via
 pinctrl
In-Reply-To: <1515759368-16946-4-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-4-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdYRXhfwZW6t3zoGg8dhizGw2ktQ1-pFh7mFZ++sab8ddQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 1:15 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> The STM32 variant hasn't the control bit to switch pads in opendrain mode.
> In this case we can achieve the same result by asking to the pinmux driver
> to configure pins for us.
>
> This patch make the mmci driver able to do this whenever needed.
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Nice and clean way to use pin control for this.
Hats off!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
