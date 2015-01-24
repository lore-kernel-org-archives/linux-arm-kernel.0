From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 24 Jan 2015 11:17:20 +0100
Subject: [PATCH v2 1/4] net: stmmac: dwmac-rk: Don't set the regulator
 voltage for phy from the driver
In-Reply-To: <1421737780-1533-2-git-send-email-romain.perier@gmail.com>
References: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
 <1421737780-1533-2-git-send-email-romain.perier@gmail.com>
Message-ID: <6351287.4ner65dylF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 20. Januar 2015, 07:09:37 schrieb Romain Perier:
> As these settings can be directly expressed from devicetree for both fixed
> regulators and pmic-integrated regulators, it is more standard to set them
> from dts and let the regulator framework use the right voltage informations
> when it is used in the driver.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Romain suggested to resend my tags against a real patch of the series, so it 
turns up in patchwork, so

This series
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Dave: as said in the v1 mail, this would be nice to have for 3.20


Heiko
