From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 09:13:55 +0000
Subject: [PATCH 2/2] ARM: imx6q: add cpu suspend/resume support in IRAM
In-Reply-To: <1325312624-22980-1-git-send-email-jason.chen@linaro.org>
References: <1325312624-22980-1-git-send-email-jason.chen@linaro.org>
Message-ID: <20120104091355.GG2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 02:23:44PM +0800, Jason Chen wrote:
> +		imx6q_iram_pm.suspend_iram_vaddr =
> +			__arm_ioremap(imx6q_iram_pm.suspend_iram_paddr,
> +					imx6q_iram_pm.suspend_iram_size,
> +					MT_MEMORY_NONCACHED);

Stop going beneath the API covers.
