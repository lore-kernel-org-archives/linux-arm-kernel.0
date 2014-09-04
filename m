From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 20:20:25 +0100
Subject: [PATCH 1/8] spi: sirf: correct spi gpio and hardware chipselect
 behaviour
In-Reply-To: <1409648468-5436-2-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-2-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904192025.GP29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:01:01PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> the old codes check the cs-gpios, if the gpio number is 0 like:
> <&gpio, 0, 0>, the driver will use the only hardware chipselect.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/72aa324f/attachment.sig>
