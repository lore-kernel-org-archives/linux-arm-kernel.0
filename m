From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 May 2018 11:28:12 -0700
Subject: [PATCH 07/14] ARM: spectre-v2: add Cortex A8 and A15 validation
 of the IBE bit
In-Reply-To: <E1fKjFJ-000641-5N@rmk-PC.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFJ-000641-5N@rmk-PC.armlinux.org.uk>
Message-ID: <20180522182811.GM98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [180521 12:09]:
> When the branch predictor hardening is enabled, firmware must have set
> the IBE bit in the auxiliary control register.  If this bit has not
> been set, the Spectre workarounds will not be functional.
> 
> Add validation that this bit is set, and print a warning at alert level
> if this is not the case.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Yup the alert is working:

Tested-by: Tony Lindgren <tony@atomide.com>
