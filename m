From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 21 Feb 2013 14:45:50 +0530
Subject: [PATCH V2] ARM: dts: exynos5250-arndale: Add PMIC node entry
In-Reply-To: <1360542984-31552-1-git-send-email-amit.daniel@samsung.com>
References: <1360542984-31552-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <5125E5C6.9020906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 06:06 AM, Amit Daniel Kachhap wrote:
> Added S5M8767 PMIC DT nodes for Arndale board. Only the used
> LDO's/BUCK are defined here. Also the nodes describe the default/reset
> state LDO's and no power mangement tuning is implemented. The usage
> desription can be found in s5m8767 device tree binding documentation.
> 
> Cc: Tushar Behera <tushar.behera@linaro.org>

Tested-by: Tushar Behera <tushar.behera@linaro.org>

> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

-- 
Tushar Behera
