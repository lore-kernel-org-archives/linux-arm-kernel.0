From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Apr 2015 15:16:54 +0200
Subject: [PATCH 1/6] Revert "staging: board: disable as it breaks the
 build"
In-Reply-To: <20150406004031.GD1841@verge.net.au>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
 <20150406004031.GD1841@verge.net.au>
Message-ID: <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 6, 2015 at 2:40 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Apr 03, 2015 at 02:41:58PM +0200, Geert Uytterhoeven wrote:
>> This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.
>>
>> Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
>> fixed the build of drivers/staging/board/board.c.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by? Reviewed-by? Tested-by? Rejected-by?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
