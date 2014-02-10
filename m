From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Feb 2014 11:20:18 +0100
Subject: [PATCH resend] pwm: Remove obsolete HAVE_PWM Kconfig symbol
In-Reply-To: <1390550056-5924-1-git-send-email-s.hauer@pengutronix.de>
References: <1390550056-5924-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140210102017.GA20143@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 08:54:16AM +0100, Sascha Hauer wrote:
> Before we had the PWM framework we used to have a barebone PWM api. The
> HAVE_PWM Kconfig symbol used to be selected by the PWM drivers to specify
> the PWM API is present in the kernel. Since the last legacy driver is gone
> the HAVE_PWM symbol can go aswell.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm at vger.kernel.orig
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> 
> Thierry as PWM maintainer has agreed to take this patch. Would be nice
> to get some Acks from affected architectures. Russell, Ralf?

No replies for over two weeks and this looks simple enough, so I just
went ahead and applied it. Thanks,

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/f772649b/attachment.sig>
