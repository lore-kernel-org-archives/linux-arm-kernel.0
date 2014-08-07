From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 16:24:48 +0200
Subject: [PATCH v2 09/11] pwm: sti: Ensure same period values for all
 channels
In-Reply-To: <1405348412-7352-10-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <1405348412-7352-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20140807142446.GB11095@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:33:30PM +0100, Lee Jones wrote:
[...]
> +/* Calculate the number of PWM devices configured with a period. */
> +unsigned int sti_pwm_count_configured(struct pwm_chip *chip)

This should've been static, which is what made sparse complain. I've
fixed it up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/15730e14/attachment.sig>
