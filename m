From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Aug 2015 22:49:32 +0200 (CEST)
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB08439BB31108FD3DDC234EDA83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
 <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC7FA4.7040902@arm.com>
 <CY1PR0301MB08433A2659C75028821F0AE783610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC96BA.2020905@arm.com>
 <CY1PR0301MB0843388CA3BB07493BC2907183610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508252126360.15006@nanos>
 <CY1PR0301MB08430902E0E46A43D00317C283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508252213220.15006@nanos>
 <CY1PR0301MB08439BB31108FD3DDC234EDA83610@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508252248040.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Shenwei Wang wrote:
> 
> IRQCHIP_SKIP_SET_WAKE flag can't be used here because the wakeup
> sources are required for power management.

You could use it. Instead of copying the saved values, you can read
the values back from the register.

Thanks,

	tglx
