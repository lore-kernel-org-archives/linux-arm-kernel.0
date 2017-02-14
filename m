From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 14 Feb 2017 15:42:52 +0100
Subject: [PATCH] PCI: Xilinx NWL: Remove mask for messages not supported
 by AXI
In-Reply-To: <8520D5D51A55D047800579B094147198263E9378@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
 <20170210202536.GI29169@bhelgaas-glaptop.roam.corp.google.com>
 <8520D5D51A55D047800579B094147198263E9378@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <1bbe7581-476b-b531-7173-cd56bc82bc66@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.2.2017 15:29, Bharat Kumar Gogada wrote:
>> On Tue, Jan 31, 2017 at 02:29:30PM +0530, Bharat Kumar Gogada wrote:
>>> - Removing support for vendor defined messages which are not
>>> suppoerted by AXI
>>>
>>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>>
>> Applied to pci/host-xilinx for v4.11, thanks.
>>
> Thanks Bjorn.
>> Bharat, get_maintainer.pl lists you as a contributor, but not as a maintainer of
>> this file.  Should we update MAINTAINERS so it does?
> Yes, Please update MAINTAINERS list.

I expect it is more about you to create a patch and send it to Bjorn.

Thanks,
Michal
