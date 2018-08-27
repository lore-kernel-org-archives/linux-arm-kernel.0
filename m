From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2018 22:22:19 +0200
Subject: [PATCH] ata: ftide010: Add a quirk for SQ201
In-Reply-To: <20180716191757.GO72677@devbig577.frc2.facebook.com>
References: <20180715200929.10116-1-linus.walleij@linaro.org>
 <20180716191757.GO72677@devbig577.frc2.facebook.com>
Message-ID: <CACRpkdbj1XU68xEuNy4yF_Tyo+Axup4vP4GpGYH0cnGZR59UGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 9:18 PM Tejun Heo <tj@kernel.org> wrote:
> On Sun, Jul 15, 2018 at 10:09:29PM +0200, Linus Walleij wrote:
> > The DMA is broken on this specific device for some unknown
> > reason (probably badly designed or plain broken interface
> > electronics) and will only work with PIO. Other users of
> > the same hardware does not have this problem.
> >
> > Add a specific quirk so that this Gemini device gets
> > DMA turned off. Also fix up some code around passing the
> > port information around in probe while we're at it.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied to libata/for-4.18-fixes.

This never appeared in the tree, it's still not there in v4.19-rc1!

Jens can you apply it?

Yours,
Linus Walleij
