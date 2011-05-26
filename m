From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 26 May 2011 15:37:55 +0530
Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank
	structure
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D178021@dbde02.ent.ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-6-git-send-email-tarun.kanti@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D178021@dbde02.ent.ti.com>
Message-ID: <BANLkTim49A1DYga62_Ys1=6+UPCSh=YW1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 15:28, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org
>> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of
>> DebBarma, Tarun Kanti
>> Sent: Tuesday, May 24, 2011 7:55 PM
>> To: linux-omap at vger.kernel.org
>> Cc: Hilman, Kevin; Shilimkar, Santosh; tony at atomide.com;
>> linux-arm-kernel at lists.infradead.org; Varadarajan, Charulatha
>> Subject: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of
>> gpio_bank structure
>>
>> From: Charulatha V <charu@ti.com>
>>
>> gpio_context array, which is used to save gpio bank's context,
>> is used only for OMAP3 architecture.
>>
>> Move gpio_context as part of gpio_bank structure so that
>> it can be specific to each gpio bank and can be used for
>> any OMAP architecture
>>
>> TODO: extend the gpio save/restore context function for OMAP4
>> architecture. This is done in one of the next patches in this
>> series
>
> [sp] Should this TODO be part of commit?

Probably this could be moved into diff section.

<<<snip>>
