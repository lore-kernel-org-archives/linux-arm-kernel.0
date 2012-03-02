From: vbyravarasu@nvidia.com (Venu Byravarasu)
Date: Fri, 2 Mar 2012 13:32:34 +0530
Subject: [PATCH v6 1/2] mfd: Add anatop mfd driver
In-Reply-To: <4F507C1B.1050909@linaro.org>
References: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
 <1330671641-6439-1-git-send-email-paul.liu@linaro.org>
 <D958900912E20642BCBC71664EFECE3E6DD2912252@BGMAIL02.nvidia.com>
 <4F507C1B.1050909@linaro.org>
Message-ID: <D958900912E20642BCBC71664EFECE3E6DD2912265@BGMAIL02.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I cannot fully understand. Anatop is not SPI or I2C device. It is
> internally embedded into the SoC. It is directly accessed by memory I/O.

Sorry, I missed this.

> Do you mean I should implement a regmap_bus which uses memory I/O and
> then use regmap?
> 
> Regards,
> Paul
