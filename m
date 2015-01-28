From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:40:48 +0000
Subject: [PATCH v2 14/15] spi/xilinx: Check number of slaves range
In-Reply-To: <1422447834-23116-15-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422447834-23116-15-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150128194048.GK21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 01:23:53PM +0100, Ricardo Ribalda Delgado wrote:

> +#define MAX_CS			32
> +

This really ought to be namespaced.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/609c954b/attachment.sig>
