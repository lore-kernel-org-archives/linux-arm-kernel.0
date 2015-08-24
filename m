From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Aug 2015 12:40:50 +0200
Subject: [PATCH] ARM: rockchip: pm: Fix PTR_ERR() argument
In-Reply-To: <1439520199-16076-1-git-send-email-festevam@gmail.com>
References: <1439520199-16076-1-git-send-email-festevam@gmail.com>
Message-ID: <1521265.IE7qZF2mhh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. August 2015, 23:43:19 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> PTR_ERR should access the value just tested by IS_ERR.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/tests/odd_ptr_err.cocci.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

applied to my soc branch.


Thanks for the catch
Heiko
