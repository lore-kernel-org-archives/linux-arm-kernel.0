From: cjb@laptop.org (Chris Ball)
Date: Sat, 09 Jul 2011 18:14:43 -0400
Subject: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
In-Reply-To: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Thu, 7 Jul 2011 00:47:46 +0800")
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <m2pqljje3w.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Jul 06 2011, Shawn Guo wrote:
> The first patch copies platform data into driver private data, and
> do not reference platform data after probe.  The second one removes
> the uses of cpu_is_mx().  The third one makes a dt related fix on
> sdhci-pltfm.c, and the last one adds actual device tree probe for
> sdhci-esdhc-imx driver.
>
> Changes since v2:
>  * Add patch #1
>  * Do not use Linux details of cd-type and wp-type for binding
>
> Changes since v1:
>  * Address review comments given by Grant
>
> Shawn Guo (4):
>       mmc: sdhci-esdhc-imx: do not reference platform data after probe
>       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
>       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
>       mmc: sdhci-esdhc-imx: add device tree probe support

These don't apply against mmc-next -- what is your tree based on?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
