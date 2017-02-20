From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 20 Feb 2017 09:40:44 +0100
Subject: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
 <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
Message-ID: <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Mon, Feb 20, 2017 at 9:30 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
>> As DaVinci uses the standard suspend_valid_only_mem() for its
>> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
>> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Looks good to me. Whats the plan for applying the series. Do you want
> the individual machine maintainers to apply their parts. Or some other?

I think the individual machine maintainers is the simplest.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
