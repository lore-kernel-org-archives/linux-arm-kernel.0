From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:34:26 +0200
Subject: [PATCH 2/8] mfd: stmpe: Add reset support for all STMPE variant
In-Reply-To: <1461068317-28016-3-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-3-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdbcr7Lz6ac27JgfLKtShP4tEjatdK80fJQRsVrsBrqrGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Reset was only implemented for STMPE1801 variant despite
> all variant have a SOFT_RESET bit.
>
> For STMPE2401/2403/801/1601/1801 SOFT_RESET bit is bit 7
> of SYS_CTRL register.
> For STMPE610/811 (which have the same variant id) SOFT_RESET
> bit is bit 1 of SYS_CTRL register.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
