From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 Dec 2013 18:15:15 -0500
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <20131213004337.GA31622@saruman.home>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com> <52AA54E4.5000606@ti.com>
 <20131213004337.GA31622@saruman.home>
Message-ID: <52AB9503.2090801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 07:43 PM, Felipe Balbi wrote:
> On Thu, Dec 12, 2013 at 07:29:24PM -0500, Santosh Shilimkar wrote:
>> On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
>>> A bare-minimum PM implementation which will
>>> server as building block for more complex
>> s/server/serve ;-)
> 
> hah! :-) will fix in my branch.
> 
>>> PM implementation in the future.
>>>
>>> At the least will not leave clocks on unnecessarily
>>> when e.g.  a user write mem to /sys/power/state.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> improve error path a little bit.
>>>
>> We will test this out. Thanks for the
>> patch Felipe.
> 
I see Wingman already tested the patch.
Feel free add, my ack if you need one...

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
