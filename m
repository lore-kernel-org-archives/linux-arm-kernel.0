From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 25 Jan 2013 09:14:15 +0530
Subject: [PATCH 01/15] ARM: shmobile: Remove duplicate inclusion of
 dma-mapping.h in setup-r8a7740.c
In-Reply-To: <20130125033841.GE620@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
 <1359080013-29189-2-git-send-email-horms+renesas@verge.net.au>
 <CAK9yfHzCywTj10sURg6z6fuVp=PtgXTyQD9evzrVVDV5a6FSdQ@mail.gmail.com>
 <20130125033841.GE620@verge.net.au>
Message-ID: <CAK9yfHw6hoi=54WjBkjDwt0kvuSPVbd6BdYLsqP_954YBP_Hgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 January 2013 09:08, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jan 25, 2013 at 08:25:27AM +0530, Sachin Kamat wrote:
>> Hi Simon,
>>
>> You seem to have changed the authorship of this patch.
>
> Sorry about that, I'll fix that up.

Thanks Simon :)


>
>> Original one at:
>> https://patchwork.kernel.org/patch/1771091/
>>
>> Regards
>> Sachin
>>
>> On 25 January 2013 07:43, Simon Horman <horms+renesas@verge.net.au> wrote:
>> > linux/dma-mapping.h was included twice.
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > ---
>> >  arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
>> >  1 file changed, 1 deletion(-)



-- 
With warm regards,
Sachin
