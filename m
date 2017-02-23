From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 23 Feb 2017 11:32:39 +0100
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run
 time changing of pwm parameters
In-Reply-To: <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
 <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
 <20170223092148.5qmxy62xkufwbsrw@piout.net>
 <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
Message-ID: <20170223103239.tv6nodddlar5l5fl@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/2017 at 12:25:58 +0200, m18063 wrote:
> > It is probably worth switching to atomic PWM instead of changing this
> > function. This would simplify the whole driver.
> I was thinking to switch to atomic PWM in a future patch.

Then why wait ?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
