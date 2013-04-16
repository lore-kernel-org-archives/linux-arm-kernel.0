From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Apr 2013 16:06:27 +0530
Subject: [PATCH v5 0/5] Patch enables support for m25p64 SPI flash support
 on da850-EVM.
In-Reply-To: <20130416102041.CC5633E14C0@localhost>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA4C560@DBDE01.ent.ti.com>
 <516BE92B.90002@ti.com> <20130416102041.CC5633E14C0@localhost>
Message-ID: <516D29AB.8000004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2013 3:50 PM, Grant Likely wrote:
> On Mon, 15 Apr 2013 17:18:59 +0530, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 4/9/2013 11:14 AM, Manjunathappa, Prakash wrote:
>>> Hi Grant,
>>>
>>> On Wed, Apr 03, 2013 at 19:39:05, Manjunathappa, Prakash wrote:
>>>> Testing information:
>>>> da850-evm comes with partitions specified in DT blob.
>>>> Able to mount/umount and create/delete files on filesystem partition.
>>>>
>>>
>>> Could you please ack the driver(1/5) and documentation(2/5) changes so
>>> that Sekhar can merge the platform changes, he doesn't have any
>>> objection on this series.
>>> http://marc.info/?l=linux-doc&m=136489750130615&w=1
>>
>> I am planning to queue these patches for ARM-SoC today. Grant has not
>> acked these but 1/5 just fixes the binding name to not use wild cards
>> and 2/5 just documents existing bindings and is something that should
>> have been merge last merge window itself (when the bindings were
>> accepted). So, the patches pending on Grant's ack seem very low risk to
>> me and we are much delayed already to wait further.
> 
> For both of those patches:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks Grant. I sent my pull request already. CCing Olof to see if
adding your ack locally when he pulls is something he is open to.

Thanks,
Sekhar
