From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 13:09:41 +0100
Subject: [PATCH v2 3/6] regulator: Add pull down support
In-Reply-To: <1434069427-3642-4-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150612120941.GQ1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:37:04PM -0700, Stephen Boyd wrote:
> Some regulators need to be configured to pull down a resistor
> when the regulator is disabled. Add an op (set_pull_down) and a
> DT property + constraint to support this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/7408196d/attachment.sig>
