From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Dec 2013 16:52:45 +0100
Subject: pwm-backlight: 3.13-rc1 regression for old arm machine
Message-ID: <87r49c6bea.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Since recently, and probable since last Linus's merge of PWM tree (Merge tag
'pwm/for-3.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm), my
platform has its backlight broken.

The particularity of my platform:
 - arch/arm/mach-pxa/mioa701.c
 - no device tree
 - no power supply regulator for backlight
 - backlight controlled by a PWM
 - kernel message :
[    1.495480] platform pwm-backlight: Driver pwm-backlight requests probe deferral

I think other "old" platforms will suffer from this. Do you have a
recommendation ?

Cheers.

--
Robert
