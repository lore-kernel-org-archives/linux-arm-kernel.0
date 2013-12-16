From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Dec 2013 14:23:37 +0100
Subject: [PATCH 2/2] pinctrl: at91: replace clk_prepare + clk_enable by
 clk_prepare_enable
In-Reply-To: <1387132252-2584-3-git-send-email-b.brezillon@overkiz.com>
References: <1387132252-2584-1-git-send-email-b.brezillon@overkiz.com>
 <1387132252-2584-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkdbzPqWFsr1bCfgd9YpmyJ-04W8Yu5R_T-M6vOczT0y57Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 7:30 PM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> Replace the clk_prepare and clk_enable calls by a single
> clk_prepare_enable call.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Patch applied with Nicolas' ACK.

Yours,
Linus Walleij
