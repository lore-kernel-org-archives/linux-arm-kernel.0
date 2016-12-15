From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 15 Dec 2016 18:49:50 +0000
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <5f667b4f-b1f3-df34-ec0d-b62061328642@synopsys.com>
References: <1481814682-31780-1-git-send-email-appanad@xilinx.com>
 <1481814682-31780-2-git-send-email-appanad@xilinx.com>
 <5f667b4f-b1f3-df34-ec0d-b62061328642@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A65C9B9@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jose Miguel Abreu,

	Thanks for the review...


> > +	chan->idle = true;
> >
> >  	spin_lock_init(&chan->lock);
> >  	INIT_LIST_HEAD(&chan->pending_list);
> 
> I think there is missing a set to true in idle when a channel reset is performed.
> Otherwise: Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Sure will fix in v2... 

Regards,
Kedar.

> 
> Best regards,
> Jose Miguel Abreu
