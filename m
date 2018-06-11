From: pawel.mikolaj.chmiel@gmail.com (=?utf-8?B?UGF3ZcWC?= Chmiel)
Date: Mon, 11 Jun 2018 20:57:39 +0200
Subject: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller
 property to gph2
In-Reply-To: <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
References: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
Message-ID: <4072275.4u7YMACK2s@acerlaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 11, 2018 2:43:59 PM CEST Krzysztof Kozlowski wrote:
> On Sun, Jun 10, 2018 at 4:15 PM, Pawe? Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> > This commit adds missing interrupt-controller property to gph2 block,
> 
> Just "Add missing". See:
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151
> 
> > to silence following warnings during build
> >   /soc/pinctrl at e0200000/gph2: Missing interrupt-controller or interrupt-map property
> >
> > Observed on not yet mainlined, an S5PV210 based
> > Samsung Galaxy S (i9000) phone.
> 
> The warning is not reproduceable (as you mentioned board is not
> present in mainline) thus please skip it. Instead, either describe
> existing reason for this change (e.g. because bindings require it for
> node of every bank of pins supporting GPIO interrupts) or include this
> in series mainlining new board (where the reason will be - it will be
> used by new board etc).
> 
> Best regards,
> Krzysztof
> 
Ok, I'll send this patch (fixed) with other patches adding new board.

Thanks
