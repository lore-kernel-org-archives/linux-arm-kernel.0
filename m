From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 May 2013 11:09:30 -0500
Subject: [PATCH RESEND] spi: sirf: fix the issue while transferring more
 than 256 words
In-Reply-To: <1368877566-27812-1-git-send-email-Baohua.Song@csr.com>
References: <1368877566-27812-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130520160930.GX1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 07:46:06PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> currently, spi irq handler only does rx processing and fetching data from rx
> fifo when "FRM_END" irq happens. FRM_END indicates one transfer completes. if
> rx size is less than 256, it works well.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130520/b9afa1bc/attachment.sig>
