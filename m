From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 11:56:45 +0530
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <87ppzww1ux.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com> <87ppzww1ux.fsf@linaro.org>
Message-ID: <51246CA5.5030403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013 12:46 AM, Kevin Hilman wrote:
> [...]
>
>>>> Just to recap what we've discussed earlier, the reasons why we want
>>>> reset and idle functions should be in the driver specific header are:
>>>>
>>>> 1. There's often driver specific logic needed in addition to the
>>>>     syconfig tinkering in the reset/idle functions.
>>>
>>> It's been a while since I last tabulated this.  But my recollection was
>>> that some kind of IP block-specific reset code is needed for about 7% to
>>> 10% of the OMAP IP blocks.
>>
>> Yes it's not too many, but the issue there is the driver specific code
>> that's duplicated in both places. And sounds like the solution to that
>> is to make driver specific reset code a static inline function in the
>> driver header as discussed earlier so bus code can call it when there's
>> no driver loaded.
>
> This thread is going in many directions and I've lost track.
>
Indeed. I lost track too and almost gave up further reading.

Regards,
Santosh
