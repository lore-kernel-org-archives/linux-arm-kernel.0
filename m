From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Mar 2013 14:03:55 +0000
Subject: [PATCH] spi: spi-s3c64xx.c Remove unused argument.
In-Reply-To: <1364290055-2970-1-git-send-email-matthias.bgg@gmail.com>
References: <1364290055-2970-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20130326140354.GU18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 10:27:35AM +0100, Matthias Brugger wrote:
> The pointer to the driver data is never used to get the slave
> controller data. We can delete the unused argument from the function.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/66f35712/attachment.sig>
