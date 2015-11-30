From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 18:24:44 +0100
Subject: [PATCH v2 1/5] i2c: add i2c quirk flag for unsupported clock
 stretching
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Message-ID: <20151130172444.GB9554@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:23PM +0100, Nicola Corna wrote:
> Add I2C_AQ_NO_CLK_STRETCH quirk flag, to be used when clock stretching is
> not supported.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/4bb983be/attachment.sig>
