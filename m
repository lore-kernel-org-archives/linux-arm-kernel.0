From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 22 Jun 2016 14:32:22 +0200
Subject: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
In-Reply-To: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <20160622123222.GD26943@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> disable the PWM, the PWM output is always set as a logic 1.

I presume there's a reason why the bootloader set this bit to 1. Why do
you assume it's the right thing to clear it?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/6ba5f7b9/attachment.sig>
