From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Oct 2013 11:57:59 -0400
Subject: [PATCH v2 3/5] dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
In-Reply-To: <20131003150359.GC16684@intel.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
 <1380580887-24249-4-git-send-email-santosh.shilimkar@ti.com>
 <20131001015454.GA16684@intel.com> <524ACFAF.7020802@ti.com>
 <20131003150359.GC16684@intel.com>
Message-ID: <524D9407.7090306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 October 2013 11:03 AM, Vinod Koul wrote:
> On Tue, Oct 01, 2013 at 09:35:43AM -0400, Santosh Shilimkar wrote:
>> On Monday 30 September 2013 09:54 PM, Vinod Koul wrote:
>>> On Mon, Sep 30, 2013 at 06:41:25PM -0400, Santosh Shilimkar wrote:
>>>> Allow the TI_EDMA to be built for ARCH_KEYSTONE which also supports
>>>> the EDMA IP.
>>>>
>>>> Cc: Vinod Koul <vinod.koul@intel.com>
>>>>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>> Vinod,
>>>> I need your ack on this patch to carry $subject patch via arm-soc tree
>>>> to avoid the unmet dependency warnings.
>>> Sure, but too many dependency fixes have been popoing up for this part and this
>>> IIRC is third patch! Something doesn't seem right, hopefully am wrong..
>>>
>> I think it mainly because EDMA support is just merged last cycle and few SOCs
>> which use the EDMA trying to enable them now.
> Okay btw is EDMA enabled in any of defconfigs. Having that will help us get
> better test covergae in -next
> 
yeah.. I do enable that as part of the series.

>>  
>>> I have a patch in my -next from Josh which selects TI_PRIV_EDMA for this...
>>>
>> I looked at your next patch which is fixing the TI_EDMA dependency.
>> If you prefer to merge $subject patch via your tree, thats fine as well.
>> Juts give me a stable branch targeted for 3.13 and I shall merge your branch
>> and apply other patches on top of it.
> Pls merge my fixes branch. I will send that to Linus in day or two...
>
Will merge your next to avoid the merge conflict issue.
 
>> Since it was very trivial patch, I thought its easy to carry via arm-soc
>> with your ack.
> Sure, looks good to me
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks a lot.

Regards,
Santosh
