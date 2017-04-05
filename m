From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Apr 2017 09:09:20 +0200
Subject: [PATCH 0/3] arm: dts: renesas: Drop _clk suffix from clock node
 names
In-Reply-To: <20170405013815.GK18246@codeaurora.org>
References: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
 <20170405013815.GK18246@codeaurora.org>
Message-ID: <CAMuHMdWSLKjcyQP25mPCwn8EV1xzAyC=AipT8E0DbeVoEeemAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Apr 5, 2017 at 3:38 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/03, Geert Uytterhoeven wrote:
>> The current practice is to not add _clk suffixes to clock node names in
>> DT, as these names are used as the actual clock names.
>>
>> This patch removes the remaining offenders in the various Renesas DTSes.
>
> This changes the names in the clk framework too though? If you're
> ok with that I'm ok too.

Yes, that's my main motivation doing this: it's a bit silly to have some clocks
show up in /sys/kernel/debug/clk/clk_summary with a "_clk" suffix.

> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
