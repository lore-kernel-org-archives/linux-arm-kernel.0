From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 18 Dec 2012 19:20:42 +1300
Subject: [PATCH 3/4] clk: vt8500: Use of_init_clk_data()
In-Reply-To: <1355778135-32458-4-git-send-email-sboyd@codeaurora.org>
References: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
 <1355778135-32458-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <1355811642.16857.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-17 at 13:02 -0800, Stephen Boyd wrote:
> Reduce lines of code and simplify this driver by using the
> generic clock binding parsing function.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/clk/clk-vt8500.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)

Looks fine, and compiles without errors/warnings.

Acked-by: Tony Prisk <linux@prisktech.co.nz>
