From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 1 Aug 2016 22:26:51 +0200
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <579F6FAF.7010001@atmel.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <579F6FAF.7010001@atmel.com>
Message-ID: <20160801202651.GB13682@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2016 at 17:50:07 +0200, Nicolas Ferre wrote :
> Le 01/08/2016 13:12, Kishon Vijay Abraham I a ?crit :
> > *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> > Fix it from getting redundantly selected in all
> > ARCH_MULTIPLATFORM based machines.
> 
> And what happens if we select just one platform independently?
> 

That is fine for us because SOC_AT91RM9200 can only be selected once
ARCH_MULTIPLATFORM is selected anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
