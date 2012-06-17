From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 17 Jun 2012 21:14:19 +0100
Subject: [PATCH] regulator: Add ramp_delay to regulator constraints to
 get used as a configurable parameter.
In-Reply-To: <1339416668-17028-1-git-send-email-yadi.brar@samsung.com>
References: <1339416668-17028-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <20120617201419.GU4267@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 05:41:08PM +0530, Yadwinder Singh Brar wrote:
> For some hardwares ramp_delay for BUCKs is a configurable parameter which can
> be configured through DT or board file.This patch adds ramp_delay to regulator
> constraints and allow user to configure it for regulators which supports this
> feature, through DT or board file. It will provide two ways of setting the
> ramp_delay for a regulator:

Applied, thanks - sorry about the delay, you submitted the day before I
flew back from China.  I rewrote the subject line to fit in 80 columns,
otherwise things like git log and pull requests look odd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120617/7d19f02e/attachment.sig>
