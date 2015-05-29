From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 May 2015 23:28:18 +0200
Subject: [PATCH 09/12] i2c: pxa: Remove compile warnning in 64bit mode
In-Reply-To: <1432818224-17070-10-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:41 +0530")
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-10-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87mw0nxedp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> From: Yipeng Yao <ypyao@marvell.com>
>
> Fix below warning message, coming from 64 bit toolchain.
>
> drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of
> different size [-Wpointer-to-int-cast]


> Signed-off-by: Yipeng Yao <ypyao@marvell.com>
> [vaibhav.hiremath at linaro.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
