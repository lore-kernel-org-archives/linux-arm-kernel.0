From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 Oct 2015 10:17:24 +0200
Subject: [PATCH] soc: rockchip: power-domain: don't try to print the clock
 name in error case
In-Reply-To: <1764593.eLkUiZigaK@diego>
References: <1764593.eLkUiZigaK@diego>
Message-ID: <49829517.ZZBFVztZIh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. Oktober 2015, 15:22:30 schrieb Heiko St?bner:
> When we never got the the clock-reference, i.e. when IS_ERR(clk) is true,
> don't try to print the clock name via %pC as this of course produces a
> null-pointer-dereference in __clk_get_name().
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied to my drivers branch with Caesar's Reviewed-tag.
