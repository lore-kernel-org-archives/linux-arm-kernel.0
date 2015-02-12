From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 12 Feb 2015 11:40:34 +0100
Subject: [PATCH] ARM: dts: zynq: Add OCM node
In-Reply-To: <20150212102615.GC1245@leverpostej>
References: <135fba212abd740584a2547903cc8d175417344c.1423736523.git.michal.simek@xilinx.com>
 <20150212102615.GC1245@leverpostej>
Message-ID: <dd043ddc72d14c4a95d8f77b67b1acfd@BN1BFFO11FD015.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/12/2015 11:26 AM, Mark Rutland wrote:
> On Thu, Feb 12, 2015 at 10:22:07AM +0000, Michal Simek wrote:
>> Add OCM node for all zynq boards. OCM location
>> can changed but for all current boards this
>> is the location where OCM is.`
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> This patch is done based on discussion here.
>> https://lkml.org/lkml/2014/12/1/396
>>
>> There are some ways how to do it.
>> OCM location can be changed but board DTS files
>> can easily rewrite it.
>> The problem which there is that node has address
>> in it but maybe someone can suggest better solution.
> 
> Given that the node is so simple, can't this be pushed down into the
> board files? So long as the label is consistent anything else that's
> referring to it should still work.

ok. Let me send v2 with moving stuff to board file and reference bus.
(I expect you will want to use different solution but will see).

Thanks,
Michal
