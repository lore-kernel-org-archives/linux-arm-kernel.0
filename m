From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 May 2017 22:33:15 +0200
Subject: [PATCH 2/4] ata: Add DT bindings for the Gemini SATA bridge
In-Reply-To: <3791456.ZibJefW5cI@amdc3058>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
 <20170506121053.11554-2-linus.walleij@linaro.org>
 <3791456.ZibJefW5cI@amdc3058>
Message-ID: <CACRpkdYz9Oka0SGJDTr=y4EN-VfggbuKY2s5X43oXg1dgjh1nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 12:49 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Saturday, May 06, 2017 02:10:51 PM Linus Walleij wrote:

>> +  Mode 3: ata0 master <-> sata0
>> +          ata1 slave  <-> sata1
>
> ata0 slave?
>
>> +          ata1 master and slave interfaces brought out
>> +               on IDE pads

Of course. Thanks for reading close, much appreciated!

Yours,
Linus Walleij
