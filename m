From: dcb314@hotmail.com (David Binderman)
Date: Fri, 28 Aug 2015 09:25:53 +0000
Subject: arch/arm/mach-omap2/vc.c:302: bad if test ?
Message-ID: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

arch/arm/mach-omap2/vc.c:302:47: warning: logical ?or? of collectively exhaustive tests is always true [-Wlogical-op]

Source code is

??????? if (!(val & OMAP3430_PRM_POLCTRL_CLKREQ_POL) ||
??????????? (val & OMAP3430_PRM_POLCTRL_CLKREQ_POL)) {

Suggest code rework.

Regards

David Binderman

 		 	   		  
