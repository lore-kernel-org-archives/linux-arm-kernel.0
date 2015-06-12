From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 13:16:55 +0100
Subject: [PATCH v2 4/6] regulator: Add soft start support
In-Reply-To: <1434069427-3642-5-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150612121655.GV1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:37:05PM -0700, Stephen Boyd wrote:
> Some regulators support a "soft start" feature where the voltage
> ramps up slowly when the regulator is enabled. Add an op
> (set_soft_start) and a DT property + constraint to support this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/10f4d15d/attachment.sig>
