From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Sep 2017 19:54:39 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
Message-ID: <20170915175439.izhfpx2ztep4evet@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 10:51:28AM -0700, Olof Johansson wrote:
> On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> [...]
> > Cc: arm at kernel.org
> > Cc: Steven Miao <realmz6@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ARM SoC folks: requesting ACK for Wolfram to take this patch.
> > Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> > Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> > Lee: requesting ACK for Wolfram to take this patch.
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> Wolfram: Same thing here, maybe this and the other patch can go on one
> branch for merge in case of conflicts.

Yes, I am fine with picking all these up. However, we already found out
there needs to be a V2 because Geert had another series cleaning up the
i2c-gpio driver and it was decided to merge those two series.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170915/a54465eb/attachment.sig>
