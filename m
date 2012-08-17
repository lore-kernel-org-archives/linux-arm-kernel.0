From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Aug 2012 08:31:27 +0800
Subject: [PATCH v4 1/3] Input: egalax_ts: get gpio from devicetree node
In-Reply-To: <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <20120817003125.GA24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 06:47:29PM +0800, Hui Wang wrote:
> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> and don't support this API anymore.
> 
> The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> and this platform already transfered to GENERIC_GPIO framework, to
> support this driver, we use a more generic way to get gpio.
> 
> Add a return value checking for waking up the controller in the probe
> function, this guarantee only a workable device can pass init.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
