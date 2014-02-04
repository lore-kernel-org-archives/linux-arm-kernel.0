From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 19:19:47 +0000
Subject: [PATCH 09/17] spi: pl022: Simplify clock handling
In-Reply-To: <1391529538-21685-10-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-10-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140204191947.GV22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:50PM +0100, Ulf Hansson wrote:
> Make use of clk_prepare_enable and clk_disable_unprepare to simplify
> code. No functional change.

I went ahead and applied this since it looks good and seems like an
unrelated cleanup to the runtime PM stuff which seems to be where the
interdependencies are - thanks!  It's on a separate branch with the
already applied change so if it does need to be cross merged we can do
that easily or even drop the branch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/04b74d44/attachment.sig>
