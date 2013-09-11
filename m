From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 11:39:03 +0100
Subject: [PATCH v3 5/8] spi: Add Freescale QuadSpi driver
In-Reply-To: <522FD833.2060801@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <1377828449-18912-6-git-send-email-b32955@freescale.com>
 <20130910180923.GC29403@sirena.org.uk>
 <522FD833.2060801@freescale.com>
Message-ID: <20130911103903.GM29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 10:40:51AM +0800, Huang Shijie wrote:
> ? 2013?09?11? 02:09, Mark Brown ??:

> > For review and merge it would be much easier to send a patch which
> > implements just the basic SPI support for this device then add the
> > support for quad mode separately.

> okay. I can remove the quad-read support in next version.

No need to remove it completely, just split it into another patch - that
way we can hopefully merge the bits that are just a standard SPI driver
first even if the other bits are still in discussion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/ac3ade0b/attachment.sig>
