From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 19:46:56 +0100
Subject: [PATCH 1/4] Revert "spi: s3c64xx: Added provision for dedicated
 cs pin"
In-Reply-To: <1405523950-2231-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140717184656.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:19:07PM +0200, Javier Martinez Canillas wrote:
> This reverts commit 3146beec21b64f4551fcf0ac148381d54dc41b1b.

For the benefit of those who haven't memorized the SHA1s of every commit
that's "spi: s3c64xx: Added provision for dedicated cs pin" - please
include the human readable format whenever you reference a SHA1.

I've applied this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/901bfe82/attachment.sig>
