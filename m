From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 16:30:13 +0530
Subject: [PATCH, RFC 8/8] ARM: dts: am43-pre-silicon support
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA86DE@DBDE01.ent.ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <e344f74da47579c11db68d9f6efe25259ed7f25d.1361186097.git.afzal@ti.com>
 <5123556A.9050109@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EAA86DE@DBDE01.ent.ti.com>
Message-ID: <51235B3D.5000907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013 04:22 PM, Mohammed, Afzal wrote:
> Hi Santosh,
>
> On Tue, Feb 19, 2013 at 16:05:22, Shilimkar, Santosh wrote:
>> On Monday 18 February 2013 05:08 PM, Afzal Mohammed wrote:
>
>>> AM43 SoC is in pre-silicon stage, meanwhile it has been modelled in
>>> a pre-silicon platform. To validate and boot Linux in pre-silicon
>>> platform that emulates an AM43 SoC, add DT build support.
>
>>> Note: This would be replaced by an original board support.
>
>>> -	am335x-bone.dtb
>>> +	am335x-bone.dtb \
>>> +	am43-pre-silicon.dtb
>
>> Well the pre-silicon platform and the SOC are very
>> close and at least the support you are adding here is
>> exactly same. So lets just use am437x.dtb or something
>> like that.
>
> SoC support is already added in patch 7/8. This is board (which doesn't
> exist now) support, hence a pre-silicon temporary one to validate it.
>
I mean we can call it am437x-xyxboard.dtb already considering the data
here can be re-used. Boot-args can be used from default kernel config
with CONFIG_CMDLINE_FORCE.

No strong opinion if you still insist to have a pre-silicon dtb.

Regards,
Santosh
