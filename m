From: dcb314@hotmail.com (David Binderman)
Date: Fri, 26 Feb 2016 08:17:54 +0000
Subject: linux-4.5-rc5/arch/arm/mach-omap2/omap-mpuss-lowpower.c:297:
 pointless assignment ?
Message-ID: <DUB128-W59C6D827674EFD33E6CFB09CA70@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.5-rc5/arch/arm/mach-omap2/omap-mpuss-lowpower.c:297]: (style) Variable 'wakeup_cpu' is assigned a value that is never used.

$ fgrep wakeup_cpu linux-4.5-rc5/arch/arm/mach-omap2/omap-mpuss-lowpower.c
??? unsigned int wakeup_cpu;
??? wakeup_cpu = smp_processor_id();
$

Suggest either assign the variable to something or remove it.
Since there is a function call involved, option 1 looks more likely to me.

Regards

David Binderman

 		 	   		  
