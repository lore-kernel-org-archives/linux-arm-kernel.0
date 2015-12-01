From: fainelli@broadcom.com (Florian Fainelli)
Date: Tue, 1 Dec 2015 15:07:34 -0800
Subject: [PATCH v4 4/5] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1448987049-17041-5-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
 <1448987049-17041-5-git-send-email-kapilh@broadcom.com>
Message-ID: <565E2836.80603@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 08:24, Kapil Hali wrote:
> Add SMP support for Broadcom's Northstar Plus SoC
> cpu enable method. This changes also consolidates
> iProc family's - BCM NSP and BCM Kona, platform
> SMP handling in a common file.
> 
> Northstar Plus SoC is based on ARM Cortex-A9
> revision r3p0 which requires configuration for ARM
> Errata 764369 for SMP. This change adds the needed
> configuration option.
> 
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>

Applied to soc/next, thanks!
-- 
Florian
