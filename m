From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:43:11 +0000
Subject: [PATCH v2 00/15] spi/xilinx: Speed-up
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150128194311.GL21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 01:23:39PM +0100, Ricardo Ribalda Delgado wrote:
> This set of patches has been developed after using the core to access a spi
> nor flash. The initial performance was not as desired. The following changes
> have been done.

Applied everything except the MAX_CS change, thanks - that's fine, just
needs the define namespacing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/a3841333/attachment.sig>
