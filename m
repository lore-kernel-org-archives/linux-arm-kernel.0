From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Mar 2013 18:46:13 +0530
Subject: [PATCH 15/15] ARM: OMAP5: PM: handle device instance for for
 coldreset
In-Reply-To: <20130301131310.GA20103@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-16-git-send-email-santosh.shilimkar@ti.com>
 <20130301130430.GA19894@kahuna> <5130A880.5080703@ti.com>
 <20130301131310.GA20103@kahuna>
Message-ID: <5130AA1D.3000303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 March 2013 06:43 PM, Nishanth Menon wrote:
> On 18:39-20130301, Santosh Shilimkar wrote:
>> On Friday 01 March 2013 06:34 PM, Nishanth Menon wrote:
>>> $subject - warm reset
>>>
>> ok
>>> On 17:41-20130301, Santosh Shilimkar wrote:
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> OMAP5 and OMAP4 have different device instance offsets.
>>>>
>>>> So to handle them properly, use a runtime detected instance offset
>>>> Other bit offsets and register offsets remained constant.
>>>>
>>>> Creating a new function is not really worthwhile here as the logic
>>>> will be replicated without much benefit.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> santosh.shilimkar at ti.com: Refreshed patch against 3.8
>>> [santosh.shilimkar at ti.com: Refreshed patch against 3.8]
>>> ?
>> #include "soc.h" :)
> I should have been clear: Did you mean to have it in [] to indicate
> contribution? A style comment based on Documentation/SubmittingPatches
> +360
> 
Ahhh. I mean that to be in []. Just missed to add the bracket.
Regards
santosh
