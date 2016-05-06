From: nm@ti.com (Nishanth Menon)
Date: Fri, 6 May 2016 07:48:12 -0500
Subject: [PATCH] ARM: dts: am57xx-idk-common: Fix input supply names
In-Reply-To: <1462493125-27832-1-git-send-email-nm@ti.com>
References: <1462493125-27832-1-git-send-email-nm@ti.com>
Message-ID: <572C928C.3080308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 07:05 PM, Nishanth Menon wrote:
[...]
>  				ldortc_reg: ldortc {
>  					/* VDDA_RTC  */
>  					vin-supply = <&vmain>;
> -					regulator-name = "ldortc";
I deleted the wrong line here!

Will repost. Sorry for the noise.

-- 
Regards,
Nishanth Menon
