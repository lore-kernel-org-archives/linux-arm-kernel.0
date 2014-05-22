From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 17:57:44 +0100
Subject: [PATCH] ASoC: samsung: Handle errors when getting the op_clk clock
In-Reply-To: <1400753452-6943-1-git-send-email-s.nawrocki@samsung.com>
References: <1400753452-6943-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140522165744.GK12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 12:10:52PM +0200, Sylwester Nawrocki wrote:
> Ensure i2s->op_clk is not used when clk_get() for this clock fails.
> This prevents working with an incorrectly configured clock in some
> conditions.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/c62cae06/attachment.sig>
