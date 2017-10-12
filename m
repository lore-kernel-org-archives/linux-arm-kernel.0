From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Thu, 12 Oct 2017 12:08:52 +0200
Subject: [PATCH V2 0/1] Optimise IOVA allocations for PCI devices
In-Reply-To: <20171012100444.GI30803@8bytes.org>
References: <1505897522-9237-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <cda4f03f-acf5-9b74-d8f1-774065bfc94e@semihalf.com>
 <20171012100444.GI30803@8bytes.org>
Message-ID: <f7210a76-399c-3767-74d0-24a98cbf7d78@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 12.10.2017 12:04, Joerg Roedel wrote:
> Hi Tomasz,
> 
> On Thu, Oct 12, 2017 at 11:40:27AM +0200, Tomasz Nowicki wrote:
>> Can you please have a look and see if you are fine with this patch?
> 
> How do these changes relate to Robin's IOVA optimizations already in the
> iommu-tree?
> 

This is another optimization patch which does not conflict with Robin's 
patches.

Robin, please correct me if I am wrong.

Thanks,
Tomasz
