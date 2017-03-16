From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Thu, 16 Mar 2017 13:22:46 +0200
Subject: [PATCH v1 0/2] Misc fixes for ARM page table allocator
 (long/short descriptor format)
In-Reply-To: <9c726317-6669-91d9-ff42-9ad47c144a3e@arm.com>
References: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
 <CAPD2p-=3Q7KKct29kjSi0=_-R7e3L5sgC-N4zS=BDa1vGc8uuQ@mail.gmail.com>
 <9c726317-6669-91d9-ff42-9ad47c144a3e@arm.com>
Message-ID: <CAPD2p-ktwFGNYCfgaxtaQ_WgGNzzEvNqcaaVDWBGQm0=1um3_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 1:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 16/03/17 09:19, Oleksandr Tyshchenko wrote:
>> Hi, all.
>>
>> Any comments?
>
> Er, no, but in a good way ;)
>
> Patches look fine to me, and I see Will's already queued them anyway.
>
> Thanks for the respin, and apologies for losing it in my inbox!
>
> Robin.

Great, thank you.

>
>>
>> On Mon, Feb 27, 2017 at 2:30 PM, Oleksandr Tyshchenko
>> <olekstysh@gmail.com> wrote:
>>> Hi.
>>>
>>> There is a small patch series which contains the same fix for both
>>> descriptor formats based on the preceding RFC patches:
>>> https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
>>> https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020477.html
>>>
>>> Oleksandr Tyshchenko (2):
>>>   iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
>>>   iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it
>>>
>>>  drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
>>>  drivers/iommu/io-pgtable-arm.c     | 6 +++++-
>>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> --
>>> 2.7.4
>>>
>>
>>
>>
>



-- 
Regards,

Oleksandr Tyshchenko
