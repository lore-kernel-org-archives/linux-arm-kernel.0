From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 15 Mar 2015 11:02:26 +0100
Subject: [PATCH 1/2] i2c: nomadik: match return type of
 wait_for_completion_timeout
In-Reply-To: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
References: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150315100226.GE6770@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 08, 2015 at 07:34:33AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> timeout is used for wait_for_completion_timeout exclusively here its
> type is simply changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/6cb88e20/attachment.sig>
