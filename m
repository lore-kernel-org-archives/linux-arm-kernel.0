From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Jan 2015 13:41:36 +0100
Subject: [PATCH 0/9] ARM: shmobile: r8a73a4/ape6evm multiplatform
In-Reply-To: <15458901.vhItGblgjS@avalon>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
 <20150122033907.GO31170@verge.net.au>
 <20150123042304.GE17548@verge.net.au> <15458901.vhItGblgjS@avalon>
Message-ID: <CAMuHMdUb=nbo=OBWXZ1jaoVwJV6LeLTEiU=ic4rEjprobn6+HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Jan 23, 2015 at 1:26 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 23 January 2015 13:23:04 Simon Horman wrote:
>> On Thu, Jan 22, 2015 at 12:39:07PM +0900, Simon Horman wrote:
>> > On Wed, Jan 21, 2015 at 10:59:27AM +0900, Simon Horman wrote:
>> >> On Tue, Jan 20, 2015 at 01:51:37PM +0100, Geert Uytterhoeven wrote:
>> >>> This series is based on renesas-drivers-2015-01-19-v3.19-rc5.
>> >>> It depends on renesas-devel-20150119-v3.19-rc5 (code-wise) and
>> >>> clk-shmobile-for-3.20 (functionality-wise), for which I've sent a pull
>> >>> request to Mike Turquette yesterday.

> I've noticed you have dropped the following patches from your devel branch:
>
> clk: shmobile: div6: Avoid changing divisor in .disable()
> clk: shmobile: Add r8a7793 support
> clk: shmobile: r8a7793: document CPG clock support
> clk: shmobile: r8a73a4 common clock framework implementation
> clk: shmobile: Add r8a73a4 SoC to MSTP bindings
> clk: shmobile: Add R-Car Gen2 RCAN clock support
> clk: shmobile: Add R-Car Gen2 ADSP clock support
>
> I don't see those patches queued in Mike Turquette's CCF tree.
>
> How should they be handled, and do they need to be delayed to v3.21 ?

I sent a pull request for these 4 days ago, cfr.
https://lkml.org/lkml/2015/1/19/391, but so far Mike hasn't pulled yet, or
hasn't published his updated tree yet.

I still hope this will happen soon...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
