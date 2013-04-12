From: tangchen@cn.fujitsu.com (Tang Chen)
Date: Fri, 12 Apr 2013 09:13:05 +0800
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <CAE9FiQU-zqFdSz-7yq5EgV1YCzyNH_BY36Ym3tdHVEHHY6cdNg@mail.gmail.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
 <51666930.6090702@cn.fujitsu.com>
 <CAE9FiQU-zqFdSz-7yq5EgV1YCzyNH_BY36Ym3tdHVEHHY6cdNg@mail.gmail.com>
Message-ID: <51675FA1.9000203@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 11:10 PM, Yinghai Lu wrote:
> On Thu, Apr 11, 2013 at 12:41 AM, Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>>
>> 3. If we add flag to memblock, we can mark different memory. And I remember
>>     you mentioned before that we can use memblock to reserve local node data
>>     for node-life-cycle data, like vmemmap, pagetable.
>>
>>     So are you doing the similar work now ?
>
> No, i did not start it yet.
>
>>
>>     If not, I think I can merge it into mine, and push a new patch-set with
>>     hot-add, hot-remove code modified to support putting vmemmap, pagetable,
>>     pgdat, page_cgroup, ..., on local node.
>
> Need to have it separated with moving_zone.
>
> 1. rework memblock to keep alive all the way for hotplug usage.
> 2. put pagetable and vmemap on the local node range with help of memblock.
>

OK?thanks for the comments. I'll merge it into my work and post an RFC 
patch-set soon.

Thanks. :)
