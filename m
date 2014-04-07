From: davem@davemloft.net (David Miller)
Date: Mon, 07 Apr 2014 14:47:01 -0400 (EDT)
Subject: [PATCH 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <1396672506-9296-3-git-send-email-zhangfei.gao@linaro.org>
References: <1396672506-9296-1-git-send-email-zhangfei.gao@linaro.org>
 <1396672506-9296-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140407.144701.2036781673003385871.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat,  5 Apr 2014 12:35:05 +0800

> +}
> +
> +
> +static int hip04_mdio_reset(struct mii_bus *bus)

Please one empty line between functions, not two.
