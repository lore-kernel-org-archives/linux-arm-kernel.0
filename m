From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 11:18:55 +0100
Subject: [PATCH] ARM: ux300: Fix unimplementable regulation constraints
In-Reply-To: <CACRpkdaJMrO8FAkSAZEc9qMm2wFzF0F1HGjpbgAFkOEkRkzmLA@mail.gmail.com>
References: <1333212293-6287-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdaJMrO8FAkSAZEc9qMm2wFzF0F1HGjpbgAFkOEkRkzmLA@mail.gmail.com>
Message-ID: <20120401101855.GA3153@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 12:00:13PM +0200, Linus Walleij wrote:
> On Sat, Mar 31, 2012 at 6:44 PM, Mark Brown

> > It doesn't make sense to grant permission to change the status of a
> > regulator that is also set as always on and similarly it doesn't make
> > sense to allow a driver to change the voltage of a regulator which can
> > only be set to a single voltage.

> Most probably correct.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Do you want me to funnel this to ARM-SoC or will you carry it in the
> regulator tree?

May as well send it via ARM-SoC, there's no interdependency with the
regulator tree here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/7def962b/attachment.sig>
