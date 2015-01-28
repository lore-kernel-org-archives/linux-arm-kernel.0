From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:57:48 +0000
Subject: [PATCH] spi/xilinx: Check number of slaves range
In-Reply-To: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150128195748.GQ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 08:53:39PM +0100, Ricardo Ribalda Delgado wrote:
> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
> 
> The core only supports up to 32 slaves, and the chipselect function
> expects the same.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/8065cb29/attachment.sig>
