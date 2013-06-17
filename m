From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Jun 2013 09:23:00 -0700
Subject: [PATCHv2 0/6] Make ARM's sched_clock generic + 64 bit friendly
In-Reply-To: <20130616094501.GG10269@tarshish>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <51AD32A4.5070609@linaro.org>
 <20130604160907.GW27516@mudshark.cambridge.arm.com>
 <51AE2980.6010005@linaro.org> <20130616094501.GG10269@tarshish>
Message-ID: <51BF37E4.8020006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2013 02:45 AM, Baruch Siach wrote:
> Hi John,
>
> On Tue, Jun 04, 2013 at 10:53:04AM -0700, John Stultz wrote:
>> On 06/04/2013 09:09 AM, Will Deacon wrote:
>>> On Tue, Jun 04, 2013 at 01:19:48AM +0100, John Stultz wrote:
>>>> On 06/01/2013 11:39 PM, Stephen Boyd wrote:
>>>>> This is mostly a resend of a patch series I sent a little over a month
>>>>> ago. I've reordered the patches so that John can pick up the first three
>>>>> and get a generic sched_clock layer without having to take the 64 bit
>>>>> patches. The last three patches add 64 bit support and move the architected
>>>>> timers on ARM64 and ARM to use it.
>>>> Yea, so from the initial look over it, I think I'm happy with queuing
>>>> the first three patches, although I'd like to get some acks from arm
>>>> folks on at least the first two, just so no one is surprised with it
>>>> going through the -tip tree.
>>> The first two patches are pretty simple so, FWIW, you can add my ack on those:
>>>
>>>    Acked-by: Will Deacon <will.deacon@arm.com>
>> Thanks! Added to the commits.
> What is the status of this series then? Is there a chance of seeing it in
> 3.11? I want to base some xtensa architecture work on this, so I'd like to
> know whether there is a stable base to start from.
I've got the first three in my internal tree, and was going to send it 
by Thomas for 3.11 this week.

Thanks for the ping!
-john
