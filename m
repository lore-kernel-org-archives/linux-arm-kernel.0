From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 13:05:24 +0100
Subject: [PATCH v2 2/6] regulator: Add system_load constraint
In-Reply-To: <1434069427-3642-3-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150612120524.GP1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:37:03PM -0700, Stephen Boyd wrote:
> Some regulators have a fixed load that isn't captured by
> consumers that the kernel knows about. Add a constraint to
> support this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/51b40f56/attachment.sig>
