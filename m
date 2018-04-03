From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Apr 2018 16:52:24 +0100
Subject: [PATCH v2 1/6] spi: core: handle timeout error from transfer_one()
In-Reply-To: <20180403152905.1524-2-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
Message-ID: <20180403155224.GA11578@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
> As long as sun4i/sun6i SPI drivers have overriden the default
> "wait for completion" procedure then we need to properly
> handle -ETIMEDOUT error from transfer_one().

Why is this connected to those drivers specifically?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/5f6f43b2/attachment.sig>
