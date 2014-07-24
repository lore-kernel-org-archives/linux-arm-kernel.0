From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Jul 2014 20:12:37 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <1405596402-23844-1-git-send-email-broonie@kernel.org>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
Message-ID: <20140724191237.GM17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> interface) removed the arch parameter from __audit_syscall_entry() and
> updated the only current user in mainline but this breaks the ARMv8 audit
> code that has been added in -next. Fix this by making the equivalent
> update to ARMv8.

This is still broken -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/e5e74e46/attachment.sig>
