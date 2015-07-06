From: vigneshr@ti.com (Vignesh R)
Date: Mon, 6 Jul 2015 11:41:43 +0530
Subject: [PATCH v2 0/5] Add support for PWMSS on DRA7
In-Reply-To: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Message-ID: <559A1C1F.7000309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 03 June 2015 05:21 PM, Vignesh R wrote:
> 
> Hi,
> 
> This patch series adds support for PWMSS on DRA7. The IP is same as that
> present in AM33XX and AM43XX.
> The first patch changes clock domain in which PWMSS is present
> (l4per2_7xx_clkdm) to SW_WKUP. This is because legacy IPs like PWM
> does'nt support HW_AUTO prorperly. Hence, switch clock domain to
> SW_WKUP. This is based on the input from the hardware team.
> The rest of the patches add hwmod and dt entries and enable PWMSS on
> DRA7 based SoCs.

Gentle ping...


-- 
Regards
Vignesh
