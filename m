From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 15 Mar 2015 10:19:42 +0100
Subject: [PATCH] i2c: wmt: use msecs_to_jiffies for time conversions
In-Reply-To: <1425216032-8163-1-git-send-email-hofrat@osadl.org>
References: <1425216032-8163-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150315091942.GC3393@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 01, 2015 at 08:20:32AM -0500, Nicholas Mc Guire wrote:
> This is only an API consolidation and should make things more readable
> it replaces var * HZ / 1000 by msecs_to_jiffies(var).
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/dacae707/attachment.sig>
