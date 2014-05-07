From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 14:50:48 +0200
Subject: [PATCH v3 17/20] phy: Add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <2511421.HV0z8e3QV0@amdc1032>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-18-git-send-email-gregory.clement@free-electrons.com>
 <2511421.HV0z8e3QV0@amdc1032>
Message-ID: <20140507145048.19bd1306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bartlomiej Zolnierkiewicz,

On Tue, 06 May 2014 13:37:04 +0200, Bartlomiej Zolnierkiewicz wrote:

> > +config ARMADA375_USBCLUSTER_PHY
> > +	def_bool y
> > +	depends on OF
> 
> Please limit this driver to Armada 375 or compile testing, i.e. add additional
> 
> 	depends on (ARCH_MVEBU && MACH_ARMADA_375) || COMPILE_TEST

Right, will do.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
