From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 30 May 2017 12:13:19 +0200
Subject: [PATCH 1/2] arm64: dts: rockchip: update common rk3399 operating
 points
In-Reply-To: <20170523095109.7337-1-heiko@sntech.de>
References: <20170523095109.7337-1-heiko@sntech.de>
Message-ID: <83138441.zQW9Y5vCCV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Mai 2017, 11:51:08 CEST schrieb Heiko Stuebner:
> The rk3399 has multiple variants with different frequency ratings.
> The operating points currently in the kernel stem from the op1 variant
> used in Gru ChromeOS devices and may not be suitable for general rk3399
> chips. Therefore bring it back to the official general operating points.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied both for 4.13 with the description in patch2 fixed and
having the patches in reverse order, as discussed in patch2.


Heiko
