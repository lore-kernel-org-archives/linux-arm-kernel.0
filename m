From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Nov 2014 16:01:55 +0100
Subject: [PATCH v11 0/3] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <1416306667-15673-1-git-send-email-yao.yuan@freescale.com>
References: <1416306667-15673-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20141118150155.GA30004@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 06:31:04PM +0800, Yuan Yao wrote:
> 
> Changed in v11: 
> - Fix the bug for 'orig_jiffies' uninitialized.
> - Use wait_for_completion_timeout() instead of wait_for_completion_interruptible_timeout(). 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/976229eb/attachment.sig>
