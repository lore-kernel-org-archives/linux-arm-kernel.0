From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 21:28:33 -0700
Subject: [GIT PULL] at91: drivers for 3.17 #1
In-Reply-To: <1404924837-20952-1-git-send-email-nicolas.ferre@atmel.com>
References: <1404924837-20952-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140713042833.GC14206@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 06:53:57PM +0200, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This update delayed to 3.17, is about replacing the existing calls to the
> older, non-standard drivers by the use of the newer "pwm-atmel" which takes
> advantage of the PWM framework.
> All concerned maintainer gave their acknowledgement to the relevant patches.
> At the end, it removes three obsolete drivers and the diffstat looks pretty
> nice as well.
> 
> Thanks, best regards,
> 
> The following changes since commit 4c834452aad01531db949414f94f817a86348d59:
> 
>   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-drivers
> 
> for you to fetch changes up to f2a70e1fc1ccc0fcdf4ad12db7382134228fb552:
> 
>   misc: atmel_pwm: remove obsolete driver (2014-07-09 15:14:35 +0200)
> 
> ----------------------------------------------------------------
> Atmel PWM driver update for 3.17
> - move to the new PWM driver which uses PWM framework
> - remove 3 obsolete drivers (atmel-pwm-bl.c, leds-atmel-pwm.c and atmel_pwm.c)
> 

Merged, thanks!


-Olof
