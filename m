From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Tue, 29 Nov 2016 22:46:26 +0100
Subject: [v6,2/2] i2c: qup: support SMBus block read
In-Reply-To: <1476203277-6893-3-git-send-email-austinwc@codeaurora.org>
References: <1476203277-6893-3-git-send-email-austinwc@codeaurora.org>
Message-ID: <20161129214626.GA23072@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 10:27:57AM -0600, Austin Christ wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
> 
> I2C QUP driver relies on SMBus emulation support from the framework.
> To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
> flag and should read the first byte received as the message length.
> 
> The driver configures the QUP hardware to read one byte. Once the
> message length is known from this byte, the QUP hardware is configured
> to read the rest.
> 
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> Reviewed-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161129/03699389/attachment.sig>
