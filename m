From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 09:25:38 +0200
Subject: [PATCH] pinctrl: sunxi: fix pin numbers passed to register
 offset helpers
In-Reply-To: <CACRpkdb14bv83yu87aps6QhO-_Map87akt9Uc04VSr2a=ZzD3w@mail.gmail.com>
References: <1400772055-3852-1-git-send-email-wens@csie.org>
 <CACRpkdb14bv83yu87aps6QhO-_Map87akt9Uc04VSr2a=ZzD3w@mail.gmail.com>
Message-ID: <20140523072538.GG27329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 12:38:09AM +0200, Linus Walleij wrote:
> On Thu, May 22, 2014 at 5:20 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> 
> > The pin numbers passed to sunxi_*_reg helpers to get the correct
> > registers should be the pin offset for the PIO block, not the
> > absolute number we use that is based on the alphanumeric labels
> > Allwinner uses.
> >
> > This patch subtracts .pin_base from the pin number passed to these
> > functions, so the driver accesses the correct registers.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Maxime, can I have your ACK on this patch, too?

You have it!

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/63b4a976/attachment.sig>
