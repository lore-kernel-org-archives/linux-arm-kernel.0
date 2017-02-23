From: Claudiu.Beznea@microchip.com (m18063)
Date: Thu, 23 Feb 2017 17:22:36 +0200
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: add support to allow run
 time changing of pwm parameters
In-Reply-To: <20170223103239.tv6nodddlar5l5fl@piout.net>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
 <1487839120-13650-3-git-send-email-claudiu.beznea@microchip.com>
 <20170223092148.5qmxy62xkufwbsrw@piout.net>
 <f963def2-6d82-3bf7-22fa-8915f408ca54@microchip.com>
 <20170223103239.tv6nodddlar5l5fl@piout.net>
Message-ID: <8123991c-5e3c-ad5c-bbf3-bcd7ee2a5e5e@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23.02.2017 12:32, Alexandre Belloni wrote:
> On 23/02/2017 at 12:25:58 +0200, m18063 wrote:
>>> It is probably worth switching to atomic PWM instead of changing this
>>> function. This would simplify the whole driver.
>> I was thinking to switch to atomic PWM in a future patch.
> Then why wait ?
>
>
I wanted to do it in progressively:
- enable the support for SAMA5d2
- make it work based on what is currently implemented
- add atomic PWM support.

Anyway, please ignore this patch. I will do it in atomic
PWM way.

Thank you,
Claudiu
