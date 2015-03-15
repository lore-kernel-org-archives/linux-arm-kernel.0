From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 15 Mar 2015 10:30:07 +0100
Subject: [PATCH] i2c: wmt: match return type of wait_for_completion_timeout
In-Reply-To: <1423392232-12937-1-git-send-email-hofrat@osadl.org>
References: <1423392232-12937-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150315093007.GG3393@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 08, 2015 at 05:43:52AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as 
> wait_result is only used for wait_for_completion_timeout here the type 
> is simply changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/1642e6e0/attachment.sig>
