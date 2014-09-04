From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 23:37:45 +0100
Subject: [PATCH 5/8] spi: sirf: add fifo reset/start for cmd transfer
In-Reply-To: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904223745.GT29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:02:34PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> for command mode spi transfer, HW spec requires to do fifo reset work to
> clear FIFO status.

Applied, thanks.  This seems like a bug fix so sohuld have been towards
the start of the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/6f256281/attachment.sig>
