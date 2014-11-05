From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Nov 2014 10:11:00 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Clocks Updates for v3.19
In-Reply-To: <20141104223054.GB5908@quad.lixom.net>
References: <cover.1414558424.git.horms+renesas@verge.net.au>
 <20141104223054.GB5908@quad.lixom.net>
Message-ID: <CAMuHMdV-h2p5wcPdYL6GPMkO7GafXs9B9h+4hjOPQmfJ37LTXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 11:30 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Oct 29, 2014 at 01:58:17PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Kevin, Hi Arnd,
>>
>> Please consider these Renesas ARM based SoC clocks updates for v3.19.
>>
>>
>> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
>>
>>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocks-for-v3.19
>>
>> for you to fetch changes up to 2b02b8020fad6ed505ff9cfb1b418c4b59f102a5:
>>
>>   ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module (2014-10-24 10:30:50 +0900)
>>
>> ----------------------------------------------------------------
>> Renesas ARM Based SoC Clocks Updates for v3.19
>>
>> * Add missing INTCA clock for irqpin module on r8a7740
>>
>> ----------------------------------------------------------------
>> Geert Uytterhoeven (1):
>>       ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
>
> Hi,
>
> I'm trying to categorize this patch and it's hard. Is it a fix for a
> bug? Support for new firmware that doesn't enable this clock? How does
> the breakage show itself, and in what circumstances? Essentially, the
> patch description doesn't describe why it's needed and what it fixes.
>
> Which means I don't know where to merge it to.

Unfortunately I've just discovered a stupid typo in that patch.
I've sent a fix ("[PATCH] ARM: shmobile: r8a7740 legacy: Fix INTCA
clock parent").

If you prefer a complete new patch including the fix, just let me know.

Sorry for the inconvenience.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
