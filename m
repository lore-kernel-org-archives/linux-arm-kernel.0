From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 26 Feb 2016 15:03:19 +0200
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <20160204233950.GH4215@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu>
Message-ID: <56D04D17.6030502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2016 01:39 AM, S?ren Brinkmann wrote:
> On Thu, 2016-02-04 at 15:14:47 -0800, Moritz Fischer wrote:
>> Hi Soeren,
>>
>> On Thu, Feb 4, 2016 at 2:41 PM, S?ren Brinkmann
>> <soren.brinkmann@xilinx.com> wrote:
>>
>>> But with this change the 'if !CPU_FREQ' becomes obsolete.
>> I'm confused, could you explain that statement? You don't want people
>> accidentally running with GT when CPU_FREQ is on, right?
> 
> Correct. But with this Kconfig rework you can just deselect it in
> Kconfig. The generic HAVE_GT could always be selected.
> 


Don't know whom should i ask - but what will be the final conclusion here?
Can it be merged?

-- 
regards,
-grygorii
