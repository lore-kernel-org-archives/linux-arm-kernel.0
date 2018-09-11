From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 18:30:06 +0100
Subject: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware
 ports
In-Reply-To: <9cf11b0c-b5c0-b39d-8c57-ad7aea5c6212@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
 <20180911170113.GA27663@e107155-lin>
 <fbde78a0-6487-7bdb-d02b-4fbf556f536e@arm.com>
 <9cf11b0c-b5c0-b39d-8c57-ad7aea5c6212@arm.com>
Message-ID: <b0ce9722-4663-ae36-83bd-59c908cd0295@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 06:23 PM, Sudeep Holla wrote:
> 
> 
> On 11/09/18 18:15, Suzuki K Poulose wrote:
>> On 09/11/2018 06:01 PM, Sudeep Holla wrote:
>>> On Tue, Sep 11, 2018 at 11:17:12AM +0100, Suzuki K Poulose wrote:
>>>> Switch to the new coresight bindings
>>>>
>>>
>>> I still see the below warnings:
>>>
>>> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
>>>  ????/replicator/in-ports: graph node has single child node 'port at 0',
>>>  ????#address-cells/#size-cells are not necessary
>>> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
>>>  ????/funnel at 20040000/out-ports: graph node has single child node
>>> 'port at 0',
>>>  ????#address-cells/#size-cells are not necessary
>>>
>>> I need the below patch to fix them, let me know if it looks OK, I can
>>> amend and apply.
>>
>> Thanks for reporting. I purposefully added the "address-cells" and
>> followed the format everywhere in the series thinking that, that is
>> indeed the formal way of doing it, rather than having implicit port
>> numbers. I can send an updated series fixing it everywhere.
>>
> No need to post the update for TC2 unless it's different from what I
> have proposed.
> 

Yes, the changes look good. Thanks Sudeep. I will drop this patch from
the next version then.

Btw, my kernel build didn't trigger those warnings.

Thanks
Suzuki
