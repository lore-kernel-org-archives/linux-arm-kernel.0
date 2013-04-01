From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:03:09 +0100
Subject: [PATCH V3 1/5] spi: s3c64xx: modified error interrupt handling
 and init
In-Reply-To: <1363157014-9615-2-git-send-email-ks.giri@samsung.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-2-git-send-email-ks.giri@samsung.com>
Message-ID: <20130401130309.GH18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 12:13:30PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> The status of the interrupt is available in the status register,
> so reading the clear pending register and writing back the same
> value will not actually clear the pending interrupts. This patch
> modifies the interrupt handler to read the status register and
> clear the corresponding pending bit in the clear pending register.

Applied, thanks.

> Signed-off-by: Girish K S <ks.giri@samsung.com>

This and the committer e-mail address (the From: above) really ought to
match up with each other.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/da459305/attachment.sig>
