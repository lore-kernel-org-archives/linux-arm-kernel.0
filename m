From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Apr 2014 12:57:45 +0100
Subject: [PATCH v4] regmap: i2c: fallback to SMBus if the adapter does
 not support standard I2C
In-Reply-To: <1398113819-22289-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398113819-22289-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140422115745.GS12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 10:56:59PM +0200, Boris BREZILLON wrote:
> Some I2C adapters are only compatible with the SMBus protocol and do not
> support standard I2C transfers.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140422/05d8275c/attachment.sig>
