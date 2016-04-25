From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 25 Apr 2016 18:30:58 +0200
Subject: [PATCH 06/14] dmaengine: bcm2835: DT spelling
 s/interrupts-names/interrupt-names/
In-Reply-To: <20160425152643.GZ2274@localhost>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
 <20160425152643.GZ2274@localhost>
Message-ID: <CAMuHMdWsAj2Tmp3hQQAwZaB39j0KM=kcsobf+NtnrAG-aX5ohg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, Apr 25, 2016 at 5:26 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Apr 20, 2016 at 05:32:11PM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
>
> This change does not apply for me, can you please split it up and send the
> sound ones thru sound tree

Sorry, I seem to have mixed two unrelated drivers.
Will split and resend...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
