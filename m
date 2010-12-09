From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 9 Dec 2010 23:31:57 +0100
Subject: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
	files
In-Reply-To: <alpine.DEB.2.00.1012072340250.13430@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012514.3708.87532.stgit@twilight.localdomain>
	<4CFDEBB7.8040309@ti.com>
	<alpine.DEB.2.00.1012072340250.13430@utopia.booyaka.com>
Message-ID: <4D0158DD.30200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Paul,

On 12/8/2010 7:47 AM, Paul Walmsley wrote:
> Salut Beno?t,
>
> On Tue, 7 Dec 2010, Cousson, Benoit wrote:
>
>> Salut Paul,
>>
>> On 12/7/2010 2:25 AM, Paul Walmsley wrote:
>>> Split the existing cm44xx.h file into cm1_44xx.h and cm2_44xx.h files
>>> so they match their underlying OMAP hardware modules.  Add clockdomain
>>> offset information.
>>>
>>> Add header files for the MPU local PRCM, prcm_mpu44xx.h, and for the
>>> SCRM, scrm44xx.h.  SCRM register offsets still need to be added; TI
>>> should do this.
>>
>> And we did it :-)
>
> Even better :-)
>
>> I sent it last week along with clock data series:
>> https://patchwork.kernel.org/patch/373751/
>>
>> OK, I've just realized that it was a little bit hidden in the clock data
>> patch, and maybe we should have been sent two patches.
>> Sorry for that. Do you want to take it in that series, or should I re-sent the
>> clock data one?
>
> I guess it's better done in the clock series; that should avoid a branch
> dependency between the PRCM patchsets and the clock patch sets.
>
> One thing that would be nice on the scrm44xx.h file is to keep the _OFFSET
> macros.  It would be nice in the long run to get rid of the absolute
> addressing macros in case someone decides to shuffle around the IP block
> addresses again... can you update your clock series with that change?

OK, this is done. I've just posted it.

Regards,
Benoit
