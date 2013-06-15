From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 15 Jun 2013 11:25:30 +0900
Subject: [PATCH] clocksource: samsung_pwm_timer: Do not request PWM mem
 region
In-Reply-To: <20130614215134.GG17326@quad.lixom.net>
References: <1371151364-8121-1-git-send-email-tomasz.figa@gmail.com>
 <20130614215134.GG17326@quad.lixom.net>
Message-ID: <172601ce696f$9b4db310$d1e91930$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Thu, Jun 13, 2013 at 09:22:44PM +0200, Tomasz Figa wrote:
> > PWM registers are shared between clocksource and PWM drivers and so can
> > not be claimed for exclusive use.
> >
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks, applied.

- Kukjin
