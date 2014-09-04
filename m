From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 23:36:09 +0100
Subject: [PATCH 4/8] spi: sirf: fix 'cmd_transfer' function typos
In-Reply-To: <1409648468-5436-5-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-5-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904223609.GS29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:01:04PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> unify 'cmd_transfer' like 'pio_transfer' and 'dma_transfer' as void
> function, and also change left_rx_word according to transfer result.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/65f37bc7/attachment-0001.sig>
