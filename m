From: vkoul@kernel.org (Vinod)
Date: Tue, 11 Sep 2018 13:11:22 +0530
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
 <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
Message-ID: <20180911074122.GM2634@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-09-18, 12:08, Radhey Shyam Pandey wrote:

> > > Yeah that part was clear but the implementation can be better..
> I thought over it and it seems having a new interface dma_ctrl_write_64
> taking lsb and msb bits input looks better and scalable. It will be similar
> to existing vdma_desc_write_64 impl. I will send v2 if it looks ok.

Yes that is much better, btw why not reuse same routine as common xilinx
lib functions :)

-- 
~Vinod
