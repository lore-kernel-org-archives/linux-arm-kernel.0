From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 16:02:42 +0100
Subject: [PATCH 1/3] spi:Add Freescale DSPI driver for Vybrid VF610
 platform
In-Reply-To: <1373272622-29064-1-git-send-email-b44548@freescale.com>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
Message-ID: <20130709150242.GC27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 04:37:00PM +0800, Chao Fu wrote:

>  drivers/spi/Kconfig        |   6 +
>  drivers/spi/Makefile       |   1 +
>  drivers/spi/spi-fsl-dspi.c | 675 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 682 insertions(+)

There is no binding documentation here.  Binding documentation is
mandatory for any new bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/46480b04/attachment.sig>
