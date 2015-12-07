From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 6 Dec 2015 19:50:44 -0800
Subject: [PATCH v6 4/5] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1449316424-14549-5-git-send-email-kapilh@broadcom.com>
References: <1449316424-14549-1-git-send-email-kapilh@broadcom.com>
 <1449316424-14549-5-git-send-email-kapilh@broadcom.com>
Message-ID: <56650214.6090401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/12/2015 03:53, Kapil Hali a ?crit :
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
