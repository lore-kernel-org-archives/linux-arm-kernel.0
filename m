From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 18:07:14 +0200
Subject: [PATCH] i2c: qup: Fix pm_runtime_get_sync usage
In-Reply-To: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
References: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140514160714.GE12911@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 08:54:29PM -0500, Andy Gross wrote:
> This patch corrects the error check on the call to pm_runtime_get_sync.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/aaec0090/attachment.sig>
