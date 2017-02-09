From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Feb 2017 11:20:29 +0800
Subject: [PATCH v4 1/3] clk: zte: add i2s clocks for zx296718
In-Reply-To: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170209032027.GP3407@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 11:12:56AM +0800, Baoyou Xie wrote:
> The i2s related clock support is missing from the existing zx296718
> clock driver. This patch adds it, so that the upstream ZX I2S driver
> can work out.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

There is no compile-time dependency between this clk patch and I2S
driver one, so it can just go via clk tree, I think.

Shawn
