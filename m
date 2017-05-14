From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 13 May 2017 20:36:28 -0700
Subject: [PATCH 2/2 v6] ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
In-Reply-To: <20170513141553.24806-1-linus.walleij@linaro.org>
References: <20170513141553.24806-1-linus.walleij@linaro.org>
Message-ID: <20170514033628.GC69278@Bjorns-MacBook-Pro-2.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 13 May 07:15 PDT 2017, Linus Walleij wrote:

> This adds the Capella CM3605 ambient light and proximity sensor
> to the APQ8060 DragonBoard device tree. Notice that we also set
> up pin config for the AOUT line and GPIO lines, and that we set
> the default trigger on the infrared LED to associate with the
> "cm3605" trigger so the IR LED is controlled by this the CM3605
> driver.
> 

Cool to see the amux in action.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
