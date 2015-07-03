From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 23:07:03 +0200
Subject: [PATCH-V2 03/12] i2c: pxa: Return I2C_RETRY when timeout in pio
 mode
In-Reply-To: <1434383399-2370-4-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Mon, 15 Jun 2015 21:19:50 +0530")
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87si959ci0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> From: Shouming Wang <wangshm@marvell.com>
>
> In case of timeout in pio mode of operation return I2C_RETRY.
> This behavior will be same as interrupt mode of operation.
>
> Signed-off-by: Shouming Wang <wangshm@marvell.com>
> [vaibhav.hiremath at linaro.org: Updated changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
