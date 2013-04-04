From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Apr 2013 15:29:00 +0000
Subject: [PATCH 00/11] ARM: integrator PCI DT adaption
In-Reply-To: <1365087696-9548-1-git-send-email-linus.walleij@linaro.org>
References: <1365087696-9548-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201304041529.00900.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013, Linus Walleij wrote:
> This patch series converts the Integrator/AP v3 PCI adapter
> to use device tree, up until the point where I try to set
> up the IRQ map and fail. Help on how to get the last patch
> working is appreciated.
> 
> This series is dependent on the first three patches for OF
> recently submitted by Thomas Petazzoni, I will not be able
> to submit them until that stuff is merged somewhere (like
> ARM SoC).

Looks very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

including the last [RFC] patch, which also looks right to me,
even though you tell me it doesn't work ;-)
