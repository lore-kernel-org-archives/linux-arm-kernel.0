From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 8 May 2017 15:52:40 -0700
Subject: [OpenWrt-Devel] [PATCH 2/4] ata: Add DT bindings for the Gemini
 SATA bridge
In-Reply-To: <CAKR_QVJTbLMzqsUTEZJOquZ9T5aQ1_=73WAoRWrm+QK9wFhngA@mail.gmail.com>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
 <20170506121053.11554-2-linus.walleij@linaro.org>
 <3791456.ZibJefW5cI@amdc3058>
 <CACRpkdYz9Oka0SGJDTr=y4EN-VfggbuKY2s5X43oXg1dgjh1nw@mail.gmail.com>
 <CAKR_QVJTbLMzqsUTEZJOquZ9T5aQ1_=73WAoRWrm+QK9wFhngA@mail.gmail.com>
Message-ID: <6e0751d2-8f78-c584-2990-c05bc3090214@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2017 02:16 PM, Tom Psyborg wrote:
> Is it ever going to be added so this endless spam can end?

It's the first iteration of the (S)ATA patchset, and if you are not
interested, just ignore the thread.

Linus is doing everyone a great favor here by making sure that this
platform gets properly supported upstream such that the cost of
maintaining in OpenWrt/LEDE/anywhere else comes down to almost zero.

Almost forgot: please don't top post.

> 
> 
> On 8 May 2017 at 22:33, Linus Walleij <linus.walleij@linaro.org
> <mailto:linus.walleij@linaro.org>> wrote:
> 
>     On Mon, May 8, 2017 at 12:49 PM, Bartlomiej Zolnierkiewicz
>     <b.zolnierkie at samsung.com <mailto:b.zolnierkie@samsung.com>> wrote:
>     > On Saturday, May 06, 2017 02:10:51 PM Linus Walleij wrote:
> 
>     >> +  Mode 3: ata0 master <-> sata0
>     >> +          ata1 slave  <-> sata1
>     >
>     > ata0 slave?
>     >
>     >> +          ata1 master and slave interfaces brought out
>     >> +               on IDE pads
> 
>     Of course. Thanks for reading close, much appreciated!
> 
>     Yours,
>     Linus Walleij
>     _______________________________________________
>     openwrt-devel mailing list
>     openwrt-devel at lists.openwrt.org <mailto:openwrt-devel@lists.openwrt.org>
>     https://lists.openwrt.org/cgi-bin/mailman/listinfo/openwrt-devel
>     <https://lists.openwrt.org/cgi-bin/mailman/listinfo/openwrt-devel>
> 
> 
> 
> 
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel at lists.openwrt.org
> https://lists.openwrt.org/cgi-bin/mailman/listinfo/openwrt-devel
> 


-- 
Florian
