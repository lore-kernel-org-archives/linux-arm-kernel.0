From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Apr 2015 20:53:39 +0100
Subject: [PATCH] spi: sirf: replace BUG condition by error code for
 unsupported transfer
In-Reply-To: <1430126548-8171-1-git-send-email-21cnbao@gmail.com>
References: <1430126548-8171-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150427195339.GD22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 09:22:28AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> return error for unsupported bits-per-word format, BUG() is not right
> for this scenerios as we are not an ASSERT but an error handler.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/c1b17b42/attachment-0001.sig>
