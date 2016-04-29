From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 09:44:13 +0200
Subject: [PATCH v2 10/10] gpio: stmpe: Add STMPE1600 support
In-Reply-To: <1461845589-4826-11-git-send-email-patrice.chotard@st.com>
References: <1461845589-4826-1-git-send-email-patrice.chotard@st.com>
 <1461845589-4826-11-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkda=EtfuQZT6wcrZM4R4FhvM9A9N6sXRrvWV2bYgiDShGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 2:13 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> The particularities of this variant are:
> - GPIO_XXX_LSB and GPIO_XXX_MSB memory locations are inverted compared
>   to other variants.
> - There is no Edge detection, Rising Edge and Falling Edge registers.
> - IRQ flags are cleared when read, no need to write in Status register.
>
> Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
