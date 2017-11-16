From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 16 Nov 2017 09:28:57 +0000
Subject: [PATCH v2] arm64: perf: remove unsupported events for Cortex-A73
In-Reply-To: <20171115175215.GM19071@arm.com>
References: <1510731566-22016-1-git-send-email-xuyiping@hisilicon.com>
 <20171115175215.GM19071@arm.com>
Message-ID: <abd5a266-152f-c4ba-7ee0-1992aba7edf0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/11/17 17:52, Will Deacon wrote:
> On Wed, Nov 15, 2017 at 03:39:26PM +0800, Xu YiPing wrote:
>> bus access read/write events are not supported in A73, based on the
>> Cortex-A73 TRM r0p2, section 11.9 Events (pages 11-457 to 11-460).
>>
>> Fixes: 5561b6c5e981 "arm64: perf: add support for Cortex-A73"
>> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
>> ---
>>   arch/arm64/kernel/perf_event.c | 6 ------
>>   1 file changed, 6 deletions(-)
> 
> Julien -- can I have your ack on this, please?

Yes, of course.

Acked-by: Julien Thierry <julien.thierry@arm.com>

> 
> Will
> 

-- 
Julien Thierry
