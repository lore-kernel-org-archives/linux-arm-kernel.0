From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 14:51:34 -0700
Subject: [PATCH] clocksource: samsung_pwm_timer: Do not request PWM mem
 region
In-Reply-To: <1371151364-8121-1-git-send-email-tomasz.figa@gmail.com>
References: <1371151364-8121-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130614215134.GG17326@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 09:22:44PM +0200, Tomasz Figa wrote:
> PWM registers are shared between clocksource and PWM drivers and so can
> not be claimed for exclusive use.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Olof Johansson <olof@lixom.net>
