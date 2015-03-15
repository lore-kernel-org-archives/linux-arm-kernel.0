From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 15 Mar 2015 10:23:39 +0100
Subject: [PATCH v3] i2c: cadence: fixup wait_for_completion_timeout
 return handling
In-Reply-To: <1423587310-18103-1-git-send-email-hofrat@osadl.org>
References: <1423587310-18103-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150315092338.GD3393@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 11:55:10AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. The
> return variable is renamed to make the timeout condition clearly readable
> and the type adjusted to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/7ee3b674/attachment.sig>
