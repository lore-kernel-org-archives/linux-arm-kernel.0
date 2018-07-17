From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 14:28:10 +0800
Subject: [PATCH v2 3/3] ARM: configs: imx_v6_v7_defconfig: add DMATEST
 support
In-Reply-To: <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
 <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180717062809.GI4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 09:08:47PM +0800, Robin Gong wrote:
> Add DMATEST support and remove invalid options, such as
> CONFIG_BT_HCIUART_H4 is default enabled and CONFIG_SND_SOC_IMX_WM8962
> is out of date and not appear in any config file. Please refer to
> Documentation/driver-api/dmaengine/dmatest.rst to test MEMCPY feature
> of imx-sdma.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied this one, thanks.
