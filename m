From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 24 Oct 2012 17:29:29 -0500
Subject: [PATCH V4 1/5] ARM: dts: OMAP: Add timer nodes
In-Reply-To: <50880C19.2090508@ti.com>
References: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
 <1350658744-13509-2-git-send-email-jon-hunter@ti.com>
 <50880C19.2090508@ti.com>
Message-ID: <50886BC9.6040800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/24/2012 10:41 AM, Benoit Cousson wrote:
> Hi Jon,
> 
> On 10/19/2012 04:59 PM, Jon Hunter wrote:
>> Add the 12 GP timers nodes present in OMAP2.
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>> Add the 7 GP timers nodes present in AM33xx.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
>> Vaibhav's original nodes adding information on which timers support a PWM
>> output.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> I updated the patch to remove the interrupt-parent from the DTS nodes and the documentation, as discussed on the list in the context of OMAP5 DTS for GPIO.
> 
> If you are OK with that version, I'll push it to Tony along with the others DTS patches.

Thanks! Yes fine with me. I have boot tested on OMAP2420, OMAP3430 and
OMAP4430.

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
