From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 14:16:49 +0200
Subject: [PATCH v2 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <1403687648-29082-2-git-send-email-zhangfei.gao@linaro.org>
References: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
 <1403687648-29082-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201406251416.49561.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 June 2014, Zhangfei Gao wrote:
> From: Jiancheng Xue <xuejiancheng@huawei.com>
> 
> Add necessary binding documentation SATA PHY on Hisilicon hix5hd2 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

We have had a couple of PHY drivers that were initially meant to be
single-purpose but then turned out to be for hardware that could
be put into multiple modes (SATA, gbit ethernet, PCIe, ...). Are
you sure that this particular device is SATA-only?

	Arnd
