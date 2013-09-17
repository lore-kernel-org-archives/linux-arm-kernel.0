From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Sep 2013 16:17:44 -0700
Subject: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3()
 which calling instruction smc #1
In-Reply-To: <201309171753.24433@pali>
References: <20130916171023.GA17477@localhost.localdomain>
 <20130917154331.GA9994@atomide.com> <201309171753.24433@pali>
Message-ID: <20130917231744.GJ9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130917 09:01]:
> On Tuesday 17 September 2013 17:43:31 Tony Lindgren wrote:
> > Have you guys checked how this works with the recently posted
> > "[PATCH v6 0/5] ARM: support for Trusted Foundations secure
> > monitor" series?
> 
> this code looks like some Tegra and "Trusted Foundations" 
> specific. There is Note: The API followed by Trusted Foundations 
> does *not* follow the SMC calling conventions.  Also code calling 
> smc #0 instruction, so in my opinion for rx51 it is useless.

OK, so still no generic SMC code then :( This patch is fine
with me.
 
> Tony, can you include this two rx51 secure patches (patch v4 1/2 
> and patch v2 2/2)? Or is there some any other problem?

No other comments on this patch, I'll post some comments on the
v2 2/2 patch considering we're moving to device tree based
booting.

Regards,

Tony
