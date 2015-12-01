From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 12:50:29 +0100
Subject: [PATCH v3 0/3] Remove ARCH_MSM* configs
In-Reply-To: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
References: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <4507574.IoXDhs75Z7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 17:25:20 Stephen Boyd wrote:
> This patch series allows us to remove the ARCH_MSM* configs that live
> in mach-qcom/Kconfig. They're mostly proxy configs for user selectable
> clocksource configurations anyway.
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I suppose we could have a QCOM_B_FAMILY option as well, but it looks
like we don't need that. Maybe mention in the help text that B_FAMILY
is always supported.

	Arnd
