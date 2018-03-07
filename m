From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Wed, 7 Mar 2018 11:55:16 +0000
Subject: [PATCH] arm64: dts: renesas: r8a7795: Add IPMMU-PV1 device node
In-Reply-To: <20180306093430.12486-1-horms+renesas@verge.net.au>
References: <20180306093430.12486-1-horms+renesas@verge.net.au>
Message-ID: <TY1PR06MB09925629ADC09D1DA9FE43E6D8D80@TY1PR06MB0992.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon-san,

> From: Simon Horman, Sent: Tuesday, March 6, 2018 6:35 PM
> 
> Add r8a7795 IPMMU-PV1 and keep it disabled by default.
> 
> This device is not present in r8a7795 ES1.x and
> is removed from the DT of those SoCs.
> 
> This corrects an omission in
> 3b7e7848f0e8 ("arm64: dts: renesas: r8a7795: Add IPMMU device nodes")
> 
> This does not have any runtime effect.
> 
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
