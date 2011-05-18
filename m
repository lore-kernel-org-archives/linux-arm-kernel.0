From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 18 May 2011 19:34:12 +0530
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
In-Reply-To: <4DD28717.1090804@ti.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>	
	<4DCD64FC.4090703@ti.com>
	<1305642091.30788.47.camel@e102391-lin.cambridge.arm.com>
	<4DD28717.1090804@ti.com>
Message-ID: <4DD3D1DC.8020708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 5/17/2011 8:02 PM, Santosh Shilimkar wrote:
> On 5/17/2011 7:51 PM, Marc Zyngier wrote:
>> Hi Santosh,
>>

[...]

>>> Looks like, this series breaks system wide supsend. Please
>>> check.
>>
>> Are you sure you're testing with v2? v1 is known to be broken with
>> CPU_HOTPLUG, but v2 should deal with it. Here is a suspend/resume cycle
>> on my Panda:
>>
> May be I tried V1 then. Will try your v2 tomorrow and let you know

V2 seems to work with suspend.

Regards
Santosh
