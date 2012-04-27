From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Apr 2012 18:44:58 +0100
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
In-Reply-To: <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120427174457.GO18260@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:02:57PM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> It tries to clk_get the clock. And if it failed, it assumes the clock
> by default enabled.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/7ccd945b/attachment.sig>
