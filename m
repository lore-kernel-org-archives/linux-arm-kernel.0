From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 21:03:45 +0100
Subject: [PATCH 3/5] spi: sirf: make GPIO chipselect function work well
In-Reply-To: <1397457001-5266-4-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-4-git-send-email-21cnbao@gmail.com>
Message-ID: <20140414200345.GV25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 02:29:59PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> orignal GPIO chipslect is not standard because it don't take care to the
> chipselect signal: BITBANG_CS_ACTIVE and BITBANG_CS_INACTIVE.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/5273b9ee/attachment.sig>
