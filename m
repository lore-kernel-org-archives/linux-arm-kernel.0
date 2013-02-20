From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 22:01:15 +0530
Subject: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
In-Reply-To: <20130220162722.GL16652@arwen.pp.htv.fi>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
 <20130220152940.GE16652@arwen.pp.htv.fi> <5124F3D4.1060307@ti.com>
 <20130220162722.GL16652@arwen.pp.htv.fi>
Message-ID: <5124FA53.8000808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013 09:57 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 20, 2013 at 09:33:32PM +0530, Santosh Shilimkar wrote:
>>>>   	default:
>>>>   		/* Unknown default to latest silicon rev as default*/
>>>> -		omap_revision = OMAP5430_REV_ES1_0;
>>>> +		omap_revision = OMAP5430_REV_ES2_0;
>>>
>>> how about we default to 0xffffffff ? That's the highest possible
>>> version, just not sure if our revision macros can cope with it.
>>>
>> :D
>> For record, it was decided that we will always have latest silicon
>> spin as default and hence OMAP5_ES2
>
> but then this line will forever be modified. Every year or so :-p
>
No... Unless and until we spin new silicon revision for OMAP5
every year. This is OMAP5 specific ID code function.

Regards,
Santosh
