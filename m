From: khilman@ti.com (Kevin Hilman)
Date: Wed, 30 Nov 2011 17:46:17 -0800
Subject: [RFC PATCH 07/11] arm:omap:am33xx: Add irq,
 dma and module base addr to SoC header files
In-Reply-To: <1321809555-13833-8-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Sun, 20 Nov 2011 22:49:11 +0530")
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-8-git-send-email-hvaibhav@ti.com>
Message-ID: <87obvtt66u.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch creats seperate irq and dma defination header file
> and updates the module base addresses required for HWMOD data.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

These headers/defines should no longer be needed.  Instead, as with
OMAP4, the raw values are used in the hwmod data (and we'll be moving
device tree for these values.)

Kevin
