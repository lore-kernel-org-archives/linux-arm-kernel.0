From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 24 Feb 2016 11:19:49 +0100
Subject: [RESEND PATCH V7 4/6] i2c: qup: Add bam dma capabilities
In-Reply-To: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org>
References: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160224101949.GB1391@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 05:38:15PM +0530, Sricharan R wrote:
> QUP cores can be attached to a BAM module, which acts as
> a dma engine for the QUP core. When DMA with BAM is enabled,
> the BAM consumer pipe transmitted data is written to the
> output FIFO and the BAM producer pipe received data is read
> from the input FIFO.
> 
> With BAM capabilities, qup-i2c core can transfer more than
> 256 bytes, without a 'stop' which is not possible otherwise.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/096b241c/attachment.sig>
