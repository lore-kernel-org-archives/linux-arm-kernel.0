From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:32:37 +0200
Subject: [PATCH 1/8] mfd: stmpe: Add STMPE_IDX_SYS_CTRL/2 enum
In-Reply-To: <1461068317-28016-2-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdafbxV-0doYYO-nbVHc_mcYFfu_OS02rpg8cBwMokgahQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> As STMPE1801/1601/24xx has a SYS_CTRL register and
> STMPE1601/2403 has even a SYS_CTRL2 register, add
> STMPE_IDX_SYS_CTRL/2 and update driver code accordingly
>
> This update prepares the ground for not yet supported STMPE1600
> which share similar REG_SYS_CTRL register.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Looks reasonable:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
