From: vkale@apm.com (Vinayak Kale)
Date: Tue, 11 Feb 2014 14:29:19 +0530
Subject: [PATCH] arm: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <52F90734.1090607@gmail.com>
References: <1391592782-18576-1-git-send-email-vkale@apm.com>
 <52F71BAD.80607@gmail.com> <20140210104355.GE25305@arm.com>
 <52F90734.1090607@gmail.com>
Message-ID: <CAPrCYkcxDHLUAG_FUv2pTwtr6JyEs9XDwbjzB4ie9qUsqs5t+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 10:37 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
> Am 10.02.2014 11:43, schrieb Catalin Marinas:
>
>> On Sun, Feb 09, 2014 at 06:09:49AM +0000, Dirk Behme wrote:
>>>
>>> Am 05.02.2014 10:33, schrieb Vinayak Kale:
>>>>
>>>> Add DSB after icache flush to complete the cache maintenance operation.
>>>>
>>>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>>>
>>>
>>> Should this go to -stable, too?
>>>
>>> I haven't looked into the details, but at least it seems to apply
>>> cleanly on a 3.8 kernel.
>>
>>
>> It should. For the similar arm64 fix I added 'cc: stable' myself (commit
>> 5044bad43ee57).
>
>
> While the arm64 patch already hit mainline, I can't find this one in
> mainline, -next or even the patch system, yet (?)
>
> Vinayak: Could you put this patch into the patch system and CC stable,
> please?
Sure.
>
> Thanks
>
> Dirk
