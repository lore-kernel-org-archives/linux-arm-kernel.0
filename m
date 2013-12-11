From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 08:48:56 +0000
Subject: [PATCH v3 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <20131210204635.GD27149@ld-irv-0074.broadcom.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-2-git-send-email-lee.jones@linaro.org>
 <20131210204635.GD27149@ld-irv-0074.broadcom.com>
Message-ID: <20131211084856.GF2390@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Thank you for taking the time to review, it's very much appreciated.
You bought out some interesting points that I'm happy to go away and
rectify. Firstly however, as I inherited this code I'd like to give
Angus a chance to comment before we go off on our own tangent and
rework some of the good code which perhaps should remain unchanged.

Angus, do you have enough time to go through Brian's review comments
and perhaps reply to the ones that you feel would benefit from your
expert knowledge. To be frank, some of the questions that were asked I
wouldn't be able to answer without your guidance in any case.

Thanks both.

Kind regards,
Lee

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
