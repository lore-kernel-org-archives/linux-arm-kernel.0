From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 14 Sep 2016 05:28:27 +0000
Subject: [PATCH 1/3] PCI: Xilinx NWL PCIe: Expanding PCIe core errors
 and printing event occurred.
In-Reply-To: <20160913151805.GD27748@localhost>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <20160913151805.GD27748@localhost>
Message-ID: <8520D5D51A55D047800579B094147198258D616B@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Aug 30, 2016 at 04:09:16PM +0530, Bharat Kumar Gogada wrote:
> > The current driver prints pcie core error, for all core events.
> > Instead of just printing PCIe core error, now adding prints to show
> > individual core events occurred.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> 
> I applied the first two patches to pci/host-xilinx for v4.9, thanks!
> 
> I'd like to work on the third one a little more, as I mentioned in my response to
> it.
> 
Thanks Bjorn, yes I agree that third one needs better way of handling.
