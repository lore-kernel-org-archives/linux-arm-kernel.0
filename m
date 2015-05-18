From: dcb314@hotmail.com (David Binderman)
Date: Mon, 18 May 2015 21:44:30 +0000
Subject: mach-pxa/pxa_cplds_irqs.c:126: bad if test ?
Message-ID: <DUB128-W342054A60A9EB2505BCA469CC40@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.1-rc4/arch/arm/mach-pxa/pxa_cplds_irqs.c:126]: (style) Checking if unsigned variable 'base_irq' is less than zero.

??? base_irq = platform_get_irq(pdev, 1);
??? if (base_irq < 0)
??????? base_irq = 0;

Suggest code rework.

Regards

David Binderman

 		 	   		  
