From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 26 May 2011 15:07:40 +0530
Subject: [PATCH 06/15] OMAP4: GPIO: Save/restore context
In-Reply-To: <8739k2sbg0.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-7-git-send-email-tarun.kanti@ti.com>
	<8739k2sbg0.fsf@ti.com>
Message-ID: <BANLkTi=xAUpL9tfnY_JScjoBK2eZf2tYsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

Thanks for the comments on this series.

On Thu, May 26, 2011 at 03:13, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Modify the omap_gpio_save/restore_context to support OMAP4
>> architecture so that the OMAP GPIO driver need not be modified
>> when OMAP4 off mode support is available.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> I don't think this patch is needed.
>
> PATCH 11/15 removes everything added in this patch when it moves to
> using the register offsets.

Okay.

>
> Kevin
>
