From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 17:25:50 +0000
Subject: [PATCH 03/18] spi/xilinx: Simplify data read from the Rx FIFO
In-Reply-To: <1422029330-10971-4-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-4-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150127172550.GA21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:35PM +0100, Ricardo Ribalda Delgado wrote:
> The number of words in the read buffer will be exactly the same as the
> number of words written on write buffer, once the transaction has
> finished.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/b0b4f073/attachment.sig>
