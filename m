From: dirk.behme@gmail.com (Dirk Behme)
Date: Mon, 10 Feb 2014 18:07:00 +0100
Subject: [PATCH] arm: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <20140210104355.GE25305@arm.com>
References: <1391592782-18576-1-git-send-email-vkale@apm.com>
 <52F71BAD.80607@gmail.com> <20140210104355.GE25305@arm.com>
Message-ID: <52F90734.1090607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.02.2014 11:43, schrieb Catalin Marinas:
> On Sun, Feb 09, 2014 at 06:09:49AM +0000, Dirk Behme wrote:
>> Am 05.02.2014 10:33, schrieb Vinayak Kale:
>>> Add DSB after icache flush to complete the cache maintenance operation.
>>>
>>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>>
>> Should this go to -stable, too?
>>
>> I haven't looked into the details, but at least it seems to apply
>> cleanly on a 3.8 kernel.
>
> It should. For the similar arm64 fix I added 'cc: stable' myself (commit
> 5044bad43ee57).

While the arm64 patch already hit mainline, I can't find this one in 
mainline, -next or even the patch system, yet (?)

Vinayak: Could you put this patch into the patch system and CC stable, 
please?

Thanks

Dirk
