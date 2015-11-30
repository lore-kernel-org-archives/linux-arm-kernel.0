From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 18:26:02 +0100
Subject: [PATCH v2 2/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
In-Reply-To: <1446118467-26453-2-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-2-git-send-email-nicola@corna.info>
Message-ID: <20151130172602.GC9554@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:24PM +0100, Nicola Corna wrote:
> Add I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when getscl
> is not available.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks! Please check git-log next time to see how
the subsystem likes its prefixes, here "i2c: algo-bit: ...".

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/4829bf49/attachment.sig>
