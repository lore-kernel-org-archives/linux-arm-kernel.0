From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Sep 2013 19:09:23 +0100
Subject: [PATCH v3 5/8] spi: Add Freescale QuadSpi driver
In-Reply-To: <1377828449-18912-6-git-send-email-b32955@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <1377828449-18912-6-git-send-email-b32955@freescale.com>
Message-ID: <20130910180923.GC29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 10:07:26AM +0800, Huang Shijie wrote:
> (0) What is the Quadspi controller?
> 
>     The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
>     one single or two external serial flash devices, each with up to 4
>     bidirectional data lines.

For review and merge it would be much easier to send a patch which
implements just the basic SPI support for this device then add the
support for quad mode separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/287f2861/attachment.sig>
