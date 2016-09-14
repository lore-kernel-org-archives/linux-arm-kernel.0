From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 14 Sep 2016 15:32:44 +0000
Subject: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt
 references.
In-Reply-To: <20160913155641.GB4138@localhost>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
 <20160913155641.GB4138@localhost>
Message-ID: <8520D5D51A55D047800579B094147198258D6418@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:
> When built with MSI support the legacy domain reference is being 
> overwritten with MSI.
> Instead creating two separate domains for MSI and legacy interrupts.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>

Applied all these (except [5/6]) with Michal's ack to pci/host-xilinx for v4.9, thanks!

I already applied Po Liu's patch ("PCI: xilinx: Relax device number checking to allow SR-IOV") to pci/virtualization.  This is identical to [5/6], so I dropped [5/6] to avoid a conflict.

Thanks Bjorn. 
Some how I couldn't find Po Liu's patch, can you provide git link of patch that was applied. 
Hope it wouldn't take much time of you. 

Thanks & Regards,
Bharat
