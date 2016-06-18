From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 16:13:28 +0200
Subject: [PATCH v4 2/2] i2c: qup: support SMBus block read
In-Reply-To: <1465409985-17113-2-git-send-email-austinwc@codeaurora.org>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <1465409985-17113-2-git-send-email-austinwc@codeaurora.org>
Message-ID: <20160618141328.GC1430@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 12:19:45PM -0600, Austin Christ wrote:
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
> Reviewed-by: sricharan at codeaurora.org

Missing name here, too. Looks good otherwise.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/7ad69151/attachment.sig>
