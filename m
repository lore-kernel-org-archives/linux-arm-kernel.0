From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Feb 2016 19:37:55 +0100
Subject: [PATCH V7 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1453197766-18976-3-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160212183755.GC1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:32:42PM +0530, Sricharan R wrote:
> QUP from version 2.1.1 onwards, supports a new format of
> i2c command tags. Tag codes instructs the controller to
> perform a operation like read/write. This new tagging version
> supports bam dma and transfers of more than 256 bytes without 'stop'
> in between. Adding the support for the same.
> 
> For each block a data_write/read tag and data_len tag is added to
> the output fifo. For the final block of data write_stop/read_stop
> tag is used.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/8c9036f4/attachment.sig>
