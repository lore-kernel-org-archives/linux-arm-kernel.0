From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sun, 16 Jan 2011 11:21:58 +0100
Subject: [PATCH] arm/tegra: Fix tegra irq_data conversion
In-Reply-To: <20110116054127.1395.68849.stgit@localhost6.localdomain6>
References: <20110116054127.1395.68849.stgit@localhost6.localdomain6>
Message-ID: <20110116102158.GC15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 10:41:27PM -0700, Grant Likely wrote:

> Commit 37337a8d5e68d6e19075dbdb3acf4f1011dae972, "ARM: tegra: irq_data
> conversion." missed changing one reference to 'irq' in the function
> tegra_gpio_irq_set_type().  This patch fixes the build error.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Lennert Buytenhek <buytenh@secretlab.ca>

I built this queue against all defconfigs, but there doesn't seem to
be one for tegra at the moment, which is why I missed this.
