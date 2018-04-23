From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Apr 2018 10:08:55 +0200
Subject: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1700954.Qkp7xggMnX@avalon>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
 <3039853.rivznOVBTv@avalon> <1700954.Qkp7xggMnX@avalon>
Message-ID: <CAMuHMdUv6Gb6D0qAnDMRYhS8Uzriv1rALXpuzuMm6ndGk24GNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Sun, Apr 22, 2018 at 10:46 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday, 21 April 2018 11:07:11 EEST Laurent Pinchart wrote:
>> On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
>> > The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
>> > only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
>> > ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
>> > than the legacy ARCH_SHMOBILE, hence use the former.
>> >
>> > This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
>> > future.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> How would you like to get this merged ?
>
> Unless you would like to merge the whole series in one go, I'll take this in
> my tree as I have a conflicting patch I would like to submit for v4.18.

Please take it in your tree, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
