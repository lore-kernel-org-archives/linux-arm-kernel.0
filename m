From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Aug 2015 09:21:34 +0200
Subject: [PATCH v2 0/2] Add R8A7794 GPIO DT support
In-Reply-To: <20150806004714.GD17231@verge.net.au>
References: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
 <20150806004714.GD17231@verge.net.au>
Message-ID: <CAMuHMdV5F2JL6_OhPY3y7WZn_pfG_ufRUe9NA+2C-CGLtVxVaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 2:47 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 04, 2015 at 12:36:27AM +0300, Sergei Shtylyov wrote:
>>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
>> 'renesas-devel-20150803-v4.2-rc5' tag. Here we add the GPIO device tree support
>> for the R8A7794 SoC.
>>
>> [1/2] ARM: shmobile: r8a7794: add GPIO clocks
>> [2/2] ARM: shmobile: r8a7794: add GPIO DT support
>
> Thanks, I have queued these up for v4.4.

Woops, Since CPG/MSTP support is in, GPIO won't work, as the nodes
lack "power-domains" properties.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
