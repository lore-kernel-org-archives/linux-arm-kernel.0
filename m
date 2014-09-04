From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 23:41:32 +0100
Subject: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
In-Reply-To: <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904224132.GW29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:02:37PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> some customers want a pure PIO transfer mode even though DMA mode is
> supported. here we give them a Kconfig option, but still keep the DMA
> enabled in default.

This doesn't feel like something for the standard kernel - can you
explain the benefit the customers think they're getting here?  It seems
like either this is something we should have as a more general option,
perhaps controllable at runtime or there's likely to be some bug or
other problem that's being worked around here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/10004a0e/attachment.sig>
