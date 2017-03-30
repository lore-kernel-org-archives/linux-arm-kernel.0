From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 30 Mar 2017 17:23:38 +0530
Subject: [PATCH v3 0/5] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
In-Reply-To: <20170329153552.GC30385@htj.duckdns.org>
References: <CGME20170322182127epcas1p267b13e8c92205223458863783bdea476@epcas1p2.samsung.com>
 <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <aaf669ba-4439-9af7-7943-c9163bd99020@ti.com> <7423344.GzQhW9fIvG@amdc3058>
 <20170329153552.GC30385@htj.duckdns.org>
Message-ID: <f5ee9343-8af2-e264-0439-c7935064d095@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 March 2017 09:05 PM, Tejun Heo wrote:
> On Fri, Mar 24, 2017 at 04:38:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> On Thursday, March 23, 2017 07:27:05 PM Sekhar Nori wrote:
>>> On Wednesday 22 March 2017 11:50 PM, Bartlomiej Zolnierkiewicz wrote:
>>>> Hi,
>>>>
>>>> This patchset adds Palmchip BK3710 IDE controller driver to
>>>> libata and switches ARM/DaVinci to use it (instead of the old
>>>> IDE driver).
>>>>
>>>> Sekhar, please check that it still works after changes, thanks.
>>>
>>> Did some basic mount/read/write tests, it passed.
>>
>> Thanks for checking.
>>
>> I guess that you can merge the patchset now to your tree
>> (with Tejun's ACK for the whole patches and Sergei's ACK
>> for ATA changes).
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Yeah, please feel free to route the series as you see fit.

Series applied to my tree for v4.12 with Tejun and Sergei's acks added.

Thanks,
Sekhar
