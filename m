From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Jun 2013 22:06:25 +0200
Subject: [PATCHv6 00/11] Remove ARM local timer API
In-Reply-To: <51ACF5E5.80503@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
 <20130531174526.GD599@codeaurora.org> <51A8E71D.1000407@linaro.org>
 <20130531221633.GG599@codeaurora.org> <51AC59AB.4080802@arm.com>
 <51ACF5E5.80503@codeaurora.org>
Message-ID: <86cfedeb1392a8eec888c96e9434fcb4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 03 Jun 2013 13:00:37 -0700, Stephen Boyd <sboyd@codeaurora.org>
wrote:
> On 06/03/13 01:54, Marc Zyngier wrote:
>> On 31/05/13 23:16, Stephen Boyd wrote:
>>> On 05/31, John Stultz wrote:
>>>> On 05/31/2013 10:45 AM, Stephen Boyd wrote:
>>>>> Comments have been light for this round so I think we're about
>>>>> ready to merge. John/Thomas, can you pick up these patches or
>>>>> shall I route them through arm-soc or something else?
>>>>
>>>> So there looks to be a fair amount of additions in the ARM tree, do
>>>> those already have acks from Arnd/Olof/other folks? (I think I was
>>>> only cc'ed on the first two patches).
>>> I'm still missing acks from Kukjin and Barry.
>> I don't think that should hold off the patch series. It's been tested
on
>> most other platforms over the course of several months. If the platform
>> maintainers aren't responsive enough, fixing the issues becomes their
>> problem.
>>
>> FWIW, have my
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks Marc. Any particular patches or should I add this to all of them?

All of them. I'm not that subtle... ;-)

        M.
-- 
Fast, cheap, reliable. Pick two.
