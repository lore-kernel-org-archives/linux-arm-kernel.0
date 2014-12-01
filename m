From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Mon, 1 Dec 2014 17:34:21 +0000
Subject: [PATCH v7 0/5] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <20141201163013.GA22708@leverpostej>
References: <1417443442-17444-1-git-send-email-bhupesh.sharma@freescale.com>
 <20141201163013.GA22708@leverpostej>
Message-ID: <CY1PR0301MB074869FD9C91C60AB98B746B877D0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> >   Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
> >   Documentation: DT: Add entry for FSL Management Complex
> 
> Are there any patches adding support for the management complex? There's
> nothing in mainline that uses "fsl,qoriq-mc", and nothing in this series
> adds support.

Yes.  Patches have been in review for the last few months.  Latest 
patch series:
   https://lkml.org/lkml/2014/11/13/482

Thanks,
Stuart
