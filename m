From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Sep 2018 12:37:58 -0700
Subject: [PATCH v2 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
In-Reply-To: <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdZBeHC3EVzGU_GNSeW_y7FBbsEibOO5JPi+LD-jhzSooA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

These bindings look good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If you want you can shorten the interrupt description by just referring
to interrupt-controller/interrupts.txt

Yours,
Linus Walleij
