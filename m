From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Sep 2018 12:40:04 -0700
Subject: [PATCH v2 2/7] mfd: Add ST Multi-Function eXpander (STMFX) core
 driver
In-Reply-To: <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdYLiBsCsFw90zGeYDpXh6wKyiqG4cJTuq+E7_2-9iXh1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> STMicroelectronics Multi-Function eXpander (STMFX) is a slave controller
> using I2C for communication with the main MCU. Main features are:
> - 16 fast GPIOs individually configurable in input/output
> - 8 alternate GPIOs individually configurable in input/output when other
> STMFX functions are not used
> - Main MCU IDD measurement
> - Resistive touchscreen controller
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

This looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
