From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 27 Jun 2012 15:39:58 +0200
Subject: [PATCH v2 2/4] pwm: pwm-mxs: use global reset function
 stmp_reset_block
In-Reply-To: <1340804165-29331-1-git-send-email-shawn.guo@linaro.org>
References: <1340701091-8488-3-git-send-email-shawn.guo@linaro.org>
 <1340804165-29331-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120627133958.GA19319@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 09:36:05PM +0800, Shawn Guo wrote:
> Use global reset function stmp_reset_block instead of mxs_reset_block
> to remove <mach/common.h> inclusion.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
> * Select STMP_DEVICE for PWM_MXS Kconfig option

Thanks, I'll apply them to for-next. Hopefully Stephen will pick them up
in linux-next real soon now. I've already sent the pull request.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/c39c921b/attachment.sig>
