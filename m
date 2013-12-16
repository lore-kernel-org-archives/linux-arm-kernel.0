From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Dec 2013 14:22:24 +0100
Subject: [PATCH 1/2] pinctrl: at91: fix clk_unprepare and clk_disable order
In-Reply-To: <1387132252-2584-2-git-send-email-b.brezillon@overkiz.com>
References: <1387132252-2584-1-git-send-email-b.brezillon@overkiz.com>
 <1387132252-2584-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkda4NQ1VR=G+EgYcMY6HcanyMU+MC3CKAq8VWtLhfonrdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 7:30 PM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> clk_unprepare shall be called before clk_disable.
> Fix the issue by replacing the clk_unprepare and clk_disable calls by a
> single clk_disable_unprepare call.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Patch applied with Nicolas' ACK.

Yours,
Linus Walleij
