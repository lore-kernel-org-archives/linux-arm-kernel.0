From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 14:49:34 +0100
Subject: [PATCH] spi: imx: fix ecspi mode setup
In-Reply-To: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
Message-ID: <20150714134934.GV11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 04:23:25PM +0300, Andrew Y. Kuksov wrote:
> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

What is the problem and how does this change fix it (this information
should be in the changelog)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/a1a1f951/attachment.sig>
