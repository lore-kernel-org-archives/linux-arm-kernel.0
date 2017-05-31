From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 May 2017 02:27:17 +0200
Subject: [PATCH] pinctrl: stm32: Fix bad function call
In-Reply-To: <1496155384-30711-1-git-send-email-alexandre.torgue@st.com>
References: <1496155384-30711-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdbsZ3hh=7cdwhVg6r2d1xCRd1QHNAwOk-8JBURAUMP8jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 4:43 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> In stm32_pconf_parse_conf function, stm32_pmx_gpio_set_direction is
> called with wrong parameter value. Indeed, using NULL value for range
> will raise an oops.
>
> Fixes: aceb16dc2da5 ("pinctrl: Add STM32 MCUs support")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
