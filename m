From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 07 Nov 2014 23:41:50 +0100
Subject: [PATCH] clk: rockchip: fix rk3188 hsadc_frac definition
In-Reply-To: <1711655.syFkKtShzb@diego>
References: <1711655.syFkKtShzb@diego>
Message-ID: <2190711.s3Jjdh7ccf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Oktober 2014, 14:26:13 schrieb Heiko St?bner:
> The arguments to COMPOSITE_FRAC for hsadc_frac were mangled, leaving out the
> the general clock flags argument. This results in strange effects, as only
> sometimes a zero-division is reported as the wrong register is read.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I've applied this into my rockchip clock branch for 3.19
