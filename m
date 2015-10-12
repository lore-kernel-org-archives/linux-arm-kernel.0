From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Oct 2015 09:12:15 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.4
In-Reply-To: <13543534.MsGb8OrGPX@wuerfel>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
 <5419864.uERWTbJ9BK@wuerfel>
 <CAMuHMdUkzv9BE4PDjm3Qkk87f2Lq6Bn-CNb+r3dtSWhbkN39Wg@mail.gmail.com>
 <13543534.MsGb8OrGPX@wuerfel>
Message-ID: <CAMuHMdX8PPprPnYNfqkof9EmT7M1YHs3vtPQ1PY=RCwGdq2zhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 6, 2015 at 8:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 October 2015 17:47:37 Geert Uytterhoeven wrote:
>> On Tue, Oct 6, 2015 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 17 September 2015 17:59:33 Simon Horman wrote:
>> >> Please consider these Renesas ARM based SoC cleanup for v4.4.
>> >>
>> >>  24 files changed, 4 insertions(+), 2687 deletions(-)
>> >>
>> >> Is a pleasing diffstat if I do say so myself.
>> >>
>> >> Of particular note the last legacy board code for Renesas ARM based SoCs,
>> >> that of the bockw board, is removed in this pull request.
>> >
>> > After a long delay in response, I've merged it now into next/cleanup.
>> >
>> > So the transition is complete and you beat me with the multiplatform
>> > conversion that I have pending for the other ARMv7 platforms, nice work!
>>
>> Thanks for pulling!
>>
>> Now I can start out sending my platform data removal series...
>
> Ok, cool.
>
> I don't think that there is generally a need to wait before sending
> stuff out that depends on pull requests to get merged.

Seems like several subsystem maintainers are uncomfortable with taking
these patches even after the legacy removal has hit arm-soc/for-next...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
