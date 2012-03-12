From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 14:23:40 +0000
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
 <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120312142340.GI3110@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 03:17:05PM +0100, Thierry Reding wrote:

> My understanding of the fixed regulator was that it was meant to be used for
> fixed voltage supplies that can still be enabled or disabled (for example as
> supplied by a GPIO) but not regulators that are fix in the sense that they
> cannot be enabled or disabled at all but are always on.

No, not at all.  It's for any random supply that doesn't have much
meaningful control - as you'll see from the code the GPIO is totally
optional if you look at the git history you'll see that the GPIO was
added some time after the driver was originally merged.

> Is that how it is supposed to work?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/209df390/attachment-0001.sig>
