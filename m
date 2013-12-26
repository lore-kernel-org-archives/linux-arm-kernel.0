From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 26 Dec 2013 12:56:25 -0500
Subject: [PATCH v2] arm: dts: keystone: add gpio device entry
In-Reply-To: <1387885972-8275-1-git-send-email-grygorii.strashko@ti.com>
References: <1387211981-26045-2-git-send-email-grygorii.strashko@ti.com>
 <1387885972-8275-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52BC6DC9.9030001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 December 2013 06:52 AM, Strashko, Grygorii wrote:
> This patch adds Keystone GPIO IP device definitions in DT which supports
> up to 32 GPIO lines and each GPIO line can be configured as separate
> interrupt source (so called "unbanked" IRQ).
> 
> For more information see:
>  http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Hi Santosh,
> 
> I've changed format of "interrupts" property as discussed.
> 
Thanks. This version looks better now. Will take this in my
queue.

Regards,
Santosh
