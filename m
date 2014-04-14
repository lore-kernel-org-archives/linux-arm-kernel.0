From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 21:03:06 +0100
Subject: [PATCH 2/5] spi: sirf: set SPI controller in RISC IO chipselect
 mode
In-Reply-To: <1397457001-5266-3-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-3-git-send-email-21cnbao@gmail.com>
Message-ID: <20140414200306.GU25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 02:29:58PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> SPI bitbang supply "chipselect" interface for change chip-select line
> , in the SiRFSoC SPI controller, we need to enable "SPI_CS_IO_MODE",

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/a5ace7ef/attachment.sig>
