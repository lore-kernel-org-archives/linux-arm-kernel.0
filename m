From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Sep 2018 12:46:36 -0700
Subject: [PATCH v2 4/7] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO
 driver
In-Reply-To: <1537363669-25991-5-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-5-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdaAN2c8AXSN7Hzvsp_N-VfnzS-EOqbiN2SR+HrtoUp6SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds pinctrl/GPIO driver for STMicroelectronics
> Multi-Function eXpander (STMFX) GPIO expander.
> STMFX is an I2C slave controller, offering up to 24 GPIOs.
> The driver relies on generic pin config interface to configure the GPIOs.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

This looks very good, exactly as I wanted it, easy to understand
and maintain.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
