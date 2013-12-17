From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Dec 2013 10:35:11 +0000
Subject: [PATCH 08/10] mfd: menelaus: Switch all children to threaded_irq
In-Reply-To: <1387238904-7843-8-git-send-email-balbi@ti.com>
References: <20131216153936.GQ18769@lee--X1>
 <1387238904-7843-1-git-send-email-balbi@ti.com>
 <1387238904-7843-8-git-send-email-balbi@ti.com>
Message-ID: <20131217103511.GC19810@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Now that we have our own irq_chip, all children can use traditional
> request_threaded_irq().

Is it possible to convert these to managed resources (*_devm)?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
