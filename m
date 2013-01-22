From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 22 Jan 2013 04:26:34 +0100
Subject: [PATCH 3/4] pinctrl: add abx500 pinctrl driver core
In-Reply-To: <1358242984-5160-1-git-send-email-linus.walleij@stericsson.com>
References: <1358242984-5160-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130122032634.GM7409@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Jan 15, 2013 at 10:43:04AM +0100, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This adds the AB8500 core driver, which will be utilized by
> the follow-on drivers for different ABx500 variants.
> Sselect the driver from the DBX500_SOC, as this chip is
> powering and clocking that SoC.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Sam, it'd be great if you could ACK this so we could proceed
> with rewriting the GPIO driver.
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
