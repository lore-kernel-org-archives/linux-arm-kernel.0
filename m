From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Jul 2014 14:48:03 +0100
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CABxcv=kcxAJz2gACAQG3H6xR1E_SBJqOkBOq=cQ7oHpndonbRw@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <20140702165651.GK410@sirena.org.uk>
 <CAHfPSqAXs=5VLLEV-XVw5YJo=-9QFn9KA8oG_A0CfNykcVwnCQ@mail.gmail.com>
 <20140707073244.GC30458@sirena.org.uk>
 <CAHfPSqAf3z9otNJivw5W7oKdRbU085+AWxCMAh8ORh=GkiNiXw@mail.gmail.com>
 <CABxcv=mw0ma3MQPsR5sGU7UcORehyyhqOtQ_SUwCNr4kpsK-7g@mail.gmail.com>
 <CABxcv=kcxAJz2gACAQG3H6xR1E_SBJqOkBOq=cQ7oHpndonbRw@mail.gmail.com>
Message-ID: <20140711134803.GW30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 01:04:07PM +0200, Javier Martinez Canillas wrote:
> Hello Naveen and Mark,
> On Mon, Jul 7, 2014 at 1:22 PM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> > On Mon, Jul 7, 2014 at 10:31 AM, Naveen Krishna Ch
> > <naveenkrishna.ch@gmail.com> wrote:

Please delete irrelevant context from your replies, this mail is over a
hundred lines long and has only three lines of new content.

> Any more opinions on this issue?

> It would be great if we can move this forward since there are other
> series that depend on these fixes.

Well, the bug with making a GPIO chip select mandatory needs to be
fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/842d413e/attachment.sig>
