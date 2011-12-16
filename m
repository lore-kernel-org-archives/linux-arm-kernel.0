From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 16 Dec 2011 18:11:08 +0530
Subject: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
 lost count if supported
In-Reply-To: <alpine.DEB.2.00.1112160538200.12660@utopia.booyaka.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
 <1320317665-6381-4-git-send-email-rnayak@ti.com> <4ED52007.8010804@ti.com>
 <4ED85835.7080108@ti.com>
 <alpine.DEB.2.00.1112160414530.12660@utopia.booyaka.com>
 <4EEB36E5.8020504@ti.com>
 <alpine.DEB.2.00.1112160538200.12660@utopia.booyaka.com>
Message-ID: <4EEB3C64.30008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2011 06:08 PM, Paul Walmsley wrote:
> On Fri, 16 Dec 2011, Rajendra Nayak wrote:
>
>> On Friday 16 December 2011 04:46 PM, Paul Walmsley wrote:
>>>
>>> Hi Rajendra,
>>>
>>> I've combined your patches down to one patch and changed the logic a
>>> little bit.  It looks to me that the update and clear context registers
>>> can be done in one step, since an IP block shouldn't lose context when
>>> it's enabled.  But maybe I'm missing something?
>>
>> Thanks for the patch. The changes look fine and I also did a quick
>> test on an internal tree which supports core OSWR and it seems to
>> work fine too.
>
> Great, thanks.  Will wait on this one until you have a chance to tinker
> with it during the 3.4 time frame.

Sure, will work some more on this and maybe re-submit it with open 
switch RET support on OMAP4 when it would really be useful and can
also be tested to work well.

thanks,
Rajendra
>
>
> - Paul
