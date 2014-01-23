From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Jan 2014 13:52:20 +0100
Subject: [PATCH] pwm: Remove obsolete HAVE_PWM Kconfig symbol
In-Reply-To: <1389884494-13729-1-git-send-email-s.hauer@pengutronix.de>
References: <1389884494-13729-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140123125219.GC28527@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 04:01:34PM +0100, Sascha Hauer wrote:
> Before we had the PWM framework we used to have a barebone PWM api. The
> HAVE_PWM Kconfig symbol used to be selected by the PWM drivers to specify
> the PWM API is present in the kernel. Since the last legacy driver is gone
> the HAVE_PWM symbol can go aswell.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> I suggest that Thierry as PWM Maintainer takes the patch through his tree.
> Is that ok for you Thierry?

Yes, that'd be my preference as well. Perhaps you can resend and add a
few more people on Cc. In particular I'd like at least Russell's (ARM)
and Ralf's (MIPS) Acked-by. Dmitry was already Cc'ed for input/misc.

The patch is rather minimal, but I'd still like to give them an
opportunity to object or at least see the patch.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/41881aa1/attachment-0001.sig>
