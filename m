From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2016 13:48:10 -0700
Subject: [PATCH] ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata
In-Reply-To: <1463077252-13078-1-git-send-email-d-gerlach@ti.com>
References: <1463077252-13078-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20160512204809.GZ5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [160512 11:23]:
> This patch explicitly enables the fixes for the below errata applicable
> for AM43x Socs as was done for OMAP4.
> 
> 754322: Faulty MMU translations following ASID switch
> 
> 775420: A data cache maintenance operation which aborts,
>         followed by an ISB, without any DSB in-between,
>         might lead to deadlock

Applying into omap-for-v4.7/fixes thanks.

Tony
