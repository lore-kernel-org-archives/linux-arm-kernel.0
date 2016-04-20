From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 10:00:23 +0200
Subject: [PATCH] rtc: hym8563: Remove CLK_IS_ROOT
In-Reply-To: <1461114838-17604-1-git-send-email-sboyd@codeaurora.org>
References: <1461114838-17604-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160420080023.GM29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2016 at 18:13:58 -0700, Stephen Boyd wrote :
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/rtc/rtc-hym8563.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
