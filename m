From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 13 Mar 2013 17:11:28 +0100
Subject: [PATCH V3 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings
 and nodes
In-Reply-To: <5140A05F.60108@ti.com>
References: <1361903244-19837-1-git-send-email-jon-hunter@ti.com>
 <1361903244-19837-2-git-send-email-jon-hunter@ti.com>
 <513F0AE3.6030408@ti.com> <513FA19C.60904@ti.com> <51409CD3.10301@ti.com>
 <5140A05F.60108@ti.com>
Message-ID: <5140A530.7030704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 04:50 PM, Jon Hunter wrote:
> 
> On 03/13/2013 10:35 AM, Benoit Cousson wrote:
>> Salut Jon,
>>
>> On 03/12/2013 10:43 PM, Jon Hunter wrote:
>>> Salut Benoit!
>>>
>>> On 03/12/2013 06:00 AM, Benoit Cousson wrote:
>>>> + Seb G.
>>>>
>>>> Hi Jon,
>>>>
>>>> How to you plan to merge that series?
>>>
>>> Good question ... my thinking was that you or Tony would take 1/2 and
>>> once that is queued then I would ask Tony to ack 2/2 and Vinod take that
>>> patch.
>>
>> Yep, this is what I was thinking too.
>>
>>> By the way, I have accumulated several DT patches which I sent out
>>> altogether [1] (at least for my own sanity if no one elses ;-) and I
>>> have included the below patch with it. I was hoping that may be I could
>>> create a branch for you to pull. If you would rather cherry-pick the
>>> various patches and merge yourself then I can separate them too.
>>
>> Merging your branch is indeed even better for me. So go ahead.
> 
> Ok. Care to take a quick review to see if there is anything else you
> feel needs fixing before I re-submit fixing the commments posted so far?

OK, I will.

> Do you have an updated branch for v3.10 that I should base on?

Yep, I've just pushed the old one rebased on top of 3.9-rc2.

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.10/dts


Regards,
Benoit
