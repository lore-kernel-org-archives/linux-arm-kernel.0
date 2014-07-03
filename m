From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Jul 2014 19:49:48 +0100
Subject: [PATCH] spi: omap2-mcspi: Configure hardware when slave driver
 changes mode
In-Reply-To: <1404271712-669-1-git-send-email-mgreer@animalcreek.com>
References: <1404271712-669-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20140703184948.GS410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 08:28:32PM -0700, Mark A. Greer wrote:
> Commit id 2bd16e3e23d9df41592c6b257c59b6860a9cc3ea
> (spi: omap2-mcspi: Do not configure the controller
> on each transfer unless needed) does its job too

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/677542d5/attachment.sig>
