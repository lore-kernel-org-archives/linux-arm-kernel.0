From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Feb 2016 19:37:47 +0100
Subject: [PATCH V7 1/6] i2c: qup: Change qup_wait_writeready function to
 use for all timeouts
In-Reply-To: <1453197766-18976-2-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160212183747.GB1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:32:41PM +0530, Sricharan R wrote:
> qup_wait_writeready waits only on a output fifo empty event.
> Change the same function to accept the event and data length
> to wait as parameters. This way the same function can be used for
> timeouts in other places as well.
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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/e9441006/attachment-0001.sig>
