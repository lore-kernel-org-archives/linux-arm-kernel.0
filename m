From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 22:56:00 +0100
Subject: [PATCH v5 03/16] pwm: Add debugfs interface
In-Reply-To: <1332945238-14897-4-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-4-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120329215600.GJ4153@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:45PM +0200, Thierry Reding wrote:
> This commit adds a debugfs interface that can be used to list the
> current internal state of the PWM devices registered with the PWM
> framework.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'm not sure I don't find the style with a file per chip more managable,
but I think that's mostly a thing for GPIOs since you get so many of
them in most systems that the file gets large which isn't such an issue
with pwms, you tend to get much fewer of them.  It's certainly a matter
of taste anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/016d21b4/attachment.sig>
