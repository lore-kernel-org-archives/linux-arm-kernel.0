From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jan 2016 22:38:09 -0600
Subject: [V5,4/6] i2c: qup: Add bam dma capabilities
In-Reply-To: <1447760727-4897-5-git-send-email-sricharan@codeaurora.org>
References: <1447760727-4897-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160109043809.GC4616@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:15:25PM +0530, Sricharan R wrote:
> QUP cores can be attached to a BAM module, which acts as a dma engine for the
> QUP core. When DMA with BAM is enabled, the BAM consumer pipe transmitted data
> is written to the output FIFO and the BAM producer pipe received data is read
> from the input FIFO.
> 
> With BAM capabilities, qup-i2c core can transfer more than 256 bytes, without a
> 'stop' which is not possible otherwise.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---

Reviewed-by: Andy Gross <andy.gross@linaro.org>
