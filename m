From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 20:13:23 -0400 (EDT)
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <53487A9E.70805@ti.com>
References: <53487A9E.70805@ti.com>
Message-ID: <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Santosh Shilimkar wrote:

> Russell,
> 
> The subject commit breaks Keystone boot with higher address space enabled.
> I haven't debugged it further but reverting that patch makes it boot again.
> 
> I will further look at it on Monday, but thought of letting you know.

See my comment at the bottom of this email which might be the cause:

http://article.gmane.org/gmane.linux.ports.arm.kernel/312721


Nicolas
