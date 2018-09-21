From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 21 Sep 2018 12:03:52 +0100
Subject: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
In-Reply-To: <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
 <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
Message-ID: <61fb0f8f-a353-8ab6-f03d-b261da435c94@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/18 10:29, Robin Murphy wrote:
> Hi John,
> 
> On 2018-09-21 10:20 AM, John Garry wrote:
>> On 20/09/2018 17:10, Robin Murphy wrote:
>>> Hi all,
>>>
>>> Hopefully this is the last spin of the series - I've now dropped my 
>>> light
>>> touch and fixed up all the various prose text, plus implemented the 
>>> proper
>>> quirk support for short-descriptor because it's actually just a trivial
>>> cut-and-paste job.
>>>
>>> Robin.
>>>
>>
>> Hi Robin,
>>
>> JFYI, I'm trying to test this patchset to get some figures and provide 
>> a tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix 
>> race handling in split_blk_unmap()" - more specifically, it seems to 
>> rely on the version which Will rewrote in your patch review, and I am 
>> not sure on what branch it exists on, if any.
> 
> Sorry, I should have said this is based on Will's iommu/devel branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel 

FWIW I've now pushed out a complete branch here:

   git://linux-arm.org/linux-rm iommu/non-strict


Robin.
