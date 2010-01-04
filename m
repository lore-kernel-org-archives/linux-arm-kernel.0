From: svenkatr@ti.com (Venkatraman S)
Date: Mon, 4 Jan 2010 14:18:50 +0530
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	<20091228214846.GP3512@atomide.com>
	<618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
Message-ID: <618f0c911001040048h573b2137v4577b8e00b0121a3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Mon, Jan 4, 2010 at 12:40 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of S, Venkatraman
>> Sent: Monday, January 04, 2010 12:33 PM
>> To: Tony Lindgren
>> Cc: Russell King - ARM Linux; Shilimkar, Santosh; Kevin Hilman; linux-omap at vger.kernel.org; linux-
>> arm-kernel at lists.infradead.org
>> Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
>>
>> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>> >> Here is the most updated version of the patch (thanks to Russell's
>> >> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>> >> Reference to previous posts
>> >> v1 ?http://marc.info/?l=linux-omap&m=125012097403050&w=2
>> >> v2 ?http://marc.info/?l=linux-omap&m=125137152606644&w=2
>> >> v3 ?http://patchwork.kernel.org/patch/45408/
>> >
>> > Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
>> > use this feature? Or some other driver?
>> >
>> > Regards,
>> >
>> > Tony
>>
>> I am about to start working on omap_hsmmc to use the descriptor load
>> feature. If the DMA changes are acceptable, I can post the driver
>> patch as well.
>
> I don't think doing this for hsmmc makes any sense considering, the IC in which DMA descriptor
> is available( OMAP3630 and OMAP4), the HSMMC controller is already equipped with its dedicated
> DMA controller (ADMA)
>
> Regards,
> Santosh
> --

AFAIK, 3630 does not have ADMA feature.
In OMAP4, ADMA support is available for MMC controllers 1 and 2 only;
the other 3 controllers still use sDMA.

Best regards,
Venkat.
