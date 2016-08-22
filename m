From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Aug 2016 18:41:38 +0100
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
In-Reply-To: <2008659.grltYsYuN0@wuerfel>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
 <2008659.grltYsYuN0@wuerfel>
Message-ID: <20160822174138.GU22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 04:49:11PM +0200, Arnd Bergmann wrote:

> Makes sense, though I think it's nicer to add the dependency to the entire
> menu, so we hide that as well, and don't have to add the line to future
> entries:

Yes, that seems better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/ba863400/attachment-0001.sig>
