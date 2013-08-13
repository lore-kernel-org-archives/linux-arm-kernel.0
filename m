From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 18:52:51 +0100
Subject: [PATCH 12/18] ARM: s3c64xx: Add support for DMA using generic
 amba-pl08x driver
In-Reply-To: <1376243970-6489-13-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-13-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130813175251.GC6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 07:59:24PM +0200, Tomasz Figa wrote:

> +#define pl330_filter pl08x_filter_id

So, this is pretty fun and probably not going to play too nicely for
multiplatform kernels...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/ee311dfa/attachment.sig>
