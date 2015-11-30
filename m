From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 18:30:10 +0100
Subject: [PATCH 4/5] i2c: add i2c_check_quirks helper function
In-Reply-To: <1446118467-26453-4-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-4-git-send-email-nicola@corna.info>
Message-ID: <20151130173010.GF9554@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:26PM +0100, Nicola Corna wrote:
> This patch adds a i2c_check_quirks helper function to check the quirk flags
> of an i2c adapter, in a similar way to i2c_check_functionality.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/d1c52025/attachment.sig>
