From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 12:30:58 +0100
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <52174640.701@gmail.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
 <20130822193453.GB10038@ld-irv-0074.broadcom.com>
 <20130822195559.GU26118@sirena.org.uk> <52174640.701@gmail.com>
Message-ID: <20130823113058.GA23465@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 04:23:44AM -0700, Brian Norris wrote:
> On 08/22/2013 12:55 PM, Mark Brown wrote:

> >That bit does need to be fixed in this driver, yes.  The SPI core now
> >has quad mode support.

> Where? Perhaps I'm missing the obvious, but I don't see SPI core
> quad support in linux-next or in Linus' tree.

It went in yesterday, -next doesn't seem to have been updated today (I
suspect Stephen may be on vacation, I'd need to check his announcement
mail from yesterday to confirm).  The SPI tree is:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/8f26d531/attachment.sig>
