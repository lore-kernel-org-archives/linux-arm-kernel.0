From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 07 Apr 2013 23:42:58 +0200
Subject: [PATCH] ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
In-Reply-To: <201304072235.02218.heiko@sntech.de>
References: <1365366170-9682-1-git-send-email-s.nawrocki@samsung.com>
 <201304072235.02218.heiko@sntech.de>
Message-ID: <5161E862.9060905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2013 10:35 PM, Heiko St?bner wrote:
> Am Sonntag, 7. April 2013, 22:22:50 schrieb Sylwester Nawrocki:
[...]
> Thanks for testing the irq changes on another subarchitecture and fixing the
> glitch.

And thanks for your effort in adding DT support for s3c24xx!

I'm still debugging one more issue, which prevents the ethernet controller
from working properly. I.e. currently booting stops on starting network 
interfaces.
There is some problem with the external interrupts handling on s3c2440. 
In my
case EINT7 does not trigger any interrupts, even though gpcon_reg and 
extint_reg
seem to be configured properly.


Regards,
Sylwester
