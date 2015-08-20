From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 10:05:35 -0700
Subject: [PATCH v3 3/8] rsb: Linux driver framework for Reduced Serial
 Bus (RSB)
In-Reply-To: <1439958009-14056-4-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
 <1439958009-14056-4-git-send-email-wens@csie.org>
Message-ID: <20150820170535.GC12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:20:04PM +0800, Chen-Yu Tsai wrote:

> Reduced Serial Bus (RSB) is an Allwinner proprietery interface
> used to communicate with PMICs and other peripheral ICs.

>  drivers/rsb/Kconfig    |  11 ++
>  drivers/rsb/Makefile   |   4 +
>  drivers/rsb/rsb-core.c | 511 +++++++++++++++++++++++++++++++++++++++++++++++++

Based on the changelog and what you were saying in your other mail about
this being very Allwinner specific I think the current trend would be to
put this into drivers/soc rather than making a new top level directory
in drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/1133c6fa/attachment.sig>
