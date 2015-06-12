From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 13:18:20 +0100
Subject: [PATCH v2 5/6] regulator: Add input current limit support
In-Reply-To: <1434069427-3642-6-git-send-email-sboyd@codeaurora.org>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150612121820.GW1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 05:37:06PM -0700, Stephen Boyd wrote:
> Some regulators can limit their input current (typically annotated
> as ilim). Add an op (set_input_current_limit) and a DT property +
> constraint to support this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/ab7c5515/attachment.sig>
