From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Oct 2012 14:32:00 +0100
Subject: [PATCH 2/2] ASoC: Ux500: Control apb clock
In-Reply-To: <1350909125-20189-2-git-send-email-ulf.hansson@stericsson.com>
References: <1350909125-20189-1-git-send-email-ulf.hansson@stericsson.com>
 <1350909125-20189-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121022133200.GG4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 02:32:05PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> When switching to common clock driver for ux500 this clock needs to
> be handled as well. Before this clock was internally managed by the
> clock driver itself.

Applied but why isn't this a deficiency in the common clock
implementation for the platform?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/fe94e73f/attachment-0001.sig>
