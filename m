From: davem@davemloft.net (David Miller)
Date: Sun, 30 Mar 2014 17:23:13 -0400 (EDT)
Subject: [PATCH 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <1396020960-6170-3-git-send-email-zhangfei.gao@linaro.org>
References: <1396020960-6170-1-git-send-email-zhangfei.gao@linaro.org>
 <1396020960-6170-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140330.172313.2128642789143277676.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 28 Mar 2014 23:35:59 +0800

> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about MOXA ART devices. If you say Y, you will be asked
> +	  for your specific card in the following questions.

Please don't just cut and paste things from unrelated Kconfig entries.

This Kconfig option has nothing to do with MOXA ART devices.
