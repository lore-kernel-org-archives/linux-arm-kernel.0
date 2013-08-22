From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 00:36:11 +0100
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <201308222229.01778.marex@denx.de>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <20130822193453.GB10038@ld-irv-0074.broadcom.com>
 <20130822195559.GU26118@sirena.org.uk>
 <201308222229.01778.marex@denx.de>
Message-ID: <20130822233611.GA25263@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:29:01PM +0200, Marek Vasut wrote:
> > On Thu, Aug 22, 2013 at 12:34:53PM -0700, Brian Norris wrote:

> > This should be a generic property for all quad devices to use, though,
> > since the same thing applies everywhere.

> Full ACK, "m25p,dual-read" and "m25p,quad-read" sound like a good prop names?

I was actually thinking something more generic than that - putting the
property at the SPI generic bindings level.  Though if all flashes with
this dual/quad read functionality have the prefix m25p the above would
work also, at the minute this does seem to be mostly used by flash (I
bet someone's got some DSPs or something though).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/815351d5/attachment-0001.sig>
