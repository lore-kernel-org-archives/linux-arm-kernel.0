From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Mar 2016 17:55:51 +0700
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <20160226152714.GD3173@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu> <56D04D17.6030502@ti.com>
 <20160226152714.GD3173@xsjsorenbubuntu>
Message-ID: <56DEAFB7.50105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 10:27 PM, S?ren Brinkmann wrote:
> On Fri, 2016-02-26 at 15:03:19 +0200, Grygorii Strashko wrote:
>> On 02/05/2016 01:39 AM, S?ren Brinkmann wrote:
>>> On Thu, 2016-02-04 at 15:14:47 -0800, Moritz Fischer wrote:
>>>> Hi Soeren,
>>>>
>>>> On Thu, Feb 4, 2016 at 2:41 PM, S?ren Brinkmann
>>>> <soren.brinkmann@xilinx.com> wrote:
>>>>
>>>>> But with this change the 'if !CPU_FREQ' becomes obsolete.
>>>> I'm confused, could you explain that statement? You don't want people
>>>> accidentally running with GT when CPU_FREQ is on, right?
>>>
>>> Correct. But with this Kconfig rework you can just deselect it in
>>> Kconfig. The generic HAVE_GT could always be selected.
>>>
>>
>>
>> Don't know whom should i ask - but what will be the final conclusion here?
>> Can it be merged?
> 
> I think we don't break anything either way. Would just be some
> additional clean up to get rid of that mentioned constraint (which
> doesn't really work well anyway in the multi-arch kernel). So, no real
> objections to merging it from my side.
> 

Yeah. Thanks

I'll re-send it after 4.6-rc.
But What I'm not fully understand is how to get it merged taking into account that
it touches few maches & clocksource :( 

-- 
regards,
-grygorii
