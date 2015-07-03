From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 22:58:38 +0200
Subject: [PATCH-V2 02/12] i2c: pxa: No need to set slave addr for i2c
 master mode reset
In-Reply-To: <1434383399-2370-3-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Mon, 15 Jun 2015 21:19:49 +0530")
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87wpyh9cw1.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> Normally i2c controller works as master, so slave addr is not needed, or it
> will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
> the same i2c address with controller.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
