From: tony@atomide.com (Tony Lindgren)
Date: Sat, 2 Feb 2013 10:16:43 -0800
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130202180747.GS2244@beef>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef>
 <2077c13e12314dc3adc8e5b653855da0@DFLE72.ent.ti.com>
 <20130201185959.GQ2244@beef>
 <e9be6668da8b4372a04687847daa1d8c@DFLE72.ent.ti.com>
 <20130202180747.GS2244@beef>
Message-ID: <20130202181643.GD577@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [130202 10:10]:
> If it doesn't work, work with Vinod to fix the api. It's expected,
> I'm working on dmaengine API changes right now to deal with a
> limitation of EDMA that needs to be abstracted.

Regarding the DMA API limitations, I'm only aware of lack of capability
to configure autoincrement at the device end. And that keeps us from
converting all GPMC related devices using omap SDMA to use the DMA API.

Are there other limitations currently known with the DMA API?

Regards,

Tony
