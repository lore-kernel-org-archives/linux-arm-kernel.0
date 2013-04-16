From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 12:20:35 +0100
Subject: [PATCH V4 2/5] spi: s3c64xx: added support for polling mode
In-Reply-To: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
Message-ID: <20130416112035.GD26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 02:10:27PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

I'm missing patch 1 of this series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/fad8a0c1/attachment.sig>
