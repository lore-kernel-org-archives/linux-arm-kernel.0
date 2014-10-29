From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 30 Oct 2014 00:54:01 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141029231154.GB23366@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
 <20141029193915.GB2542@atomide.com>
 <20141029231154.GB23366@drone.musicnaut.iki.fi>
Message-ID: <CABxcv==FAfYmLY9oA7Yd6OQuXPNmpkZsTg03no8VoD9fCBwgHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

On Thu, Oct 30, 2014 at 12:11 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Wed, Oct 29, 2014 at 12:39:16PM -0700, Tony Lindgren wrote:
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Mon, 27 Oct 2014 13:05:54 -0700
>> Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
>>
>> We're moving omaps to use device tree based booting and already have
>> omap2, omap4, omap5, am335x and am437x booting in device tree only
>> mode.
>>
>> Only omap3 still has legacy booting still around and we really want
>> to make that device tree only. So let's add a warning about deprecated
>> legacy booting so we get people to upgrade their boards to use device
>> tree based booting and find out about any remaining issues.
>>
>> Note that for most boards we already have the .dts file and those can
>> be booted with without changing the bootloader using the appended
>> DTB mode.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
