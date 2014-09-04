From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 23:39:13 +0100
Subject: [PATCH 6/8] spi: sirf: set default spi frequency if it is not set
In-Reply-To: <1409648557-5470-2-git-send-email-Barry.Song@csr.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-2-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904223913.GU29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:02:35PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> give spi a default frequence if it is not set and the value is 0.

I think this is a good idea but I think we should do this in the SPI
core rather than this driver since the same thing is going to apply to
many drivers.  Can you do a patch for that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/885ecdda/attachment.sig>
