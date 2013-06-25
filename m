From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Jun 2013 16:40:20 +0100
Subject: [PATCH] spi: sirf: add missed spi mode_bits that SiRFSoC
 hardware supports
In-Reply-To: <1372160729-12796-1-git-send-email-Baohua.Song@csr.com>
References: <1372160729-12796-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130625154020.GG27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 07:45:29PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> Missing this will cause some user cases fail when they want to change spi
> transfer mode.

This doesn't seem to apply against the current SPI code or mainline -
can you please check and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/a3e10f12/attachment.sig>
