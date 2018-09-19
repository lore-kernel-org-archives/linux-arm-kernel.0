From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Sep 2018 12:47:57 -0700
Subject: [PATCH v2 6/7] ARM: dts: stm32: add joystick support on
 stm32746g-eval
In-Reply-To: <1537363669-25991-7-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-7-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdZ4nCV3g7Noi9eTQvvXpWhsR46d0Fygt=uUS3aJdjRtyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> The joystick (B3) on stm32746g-eval uses gpios on STMFX gpio expander.
> These gpios need a pin configuration (push-pull and bias-pull-up),
> described under stmfx_pinctrl node.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
