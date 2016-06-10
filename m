From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 05:03:32 -0700
Subject: [PATCH v8 8/9] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
In-Reply-To: <1462291015-1919-9-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-9-git-send-email-fcooper@ti.com>
Message-ID: <20160610120332.GL22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> Devices that utilize the OCP registers and/or PRCM registers and
> register bit fields should be modeled using hwmod. Since eQEP, ePWM and
> eCAP don't fall under this category, remove their hwmod entries.
> 
> Instead these clocks simply use the clock that is passed through by its
> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
> subdevices.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>

And this one I'm applying into omap-for-v4.8/soc.

Tony
