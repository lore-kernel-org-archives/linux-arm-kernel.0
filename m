From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Feb 2016 22:29:28 +0100
Subject: [PATCH v5 8/8] ARM: dts: rockchip: support the spi for rk3036
In-Reply-To: <1454384453-7127-4-git-send-email-wxt@rock-chips.com>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
 <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
 <1454384453-7127-4-git-send-email-wxt@rock-chips.com>
Message-ID: <8822283.9IqfJnsVut@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 2. Februar 2016, 11:40:53 schrieb Caesar Wang:
> This patch adds the needed spi node for rk3036 dts.
> 
> We have to use the 4 bus emmc to work if someone want to support
> the spi devices, since the pins are re-used by emmc data[5-8] and spi.
> In some caseswe need to support the spi devices, that will waste the
> emmc performance.
> 
> Moment, the kylin/evb hasn't the spi devices to work, so maybe we need wait
> the new required to enable in kylin/evb board.
> 
> Anyway, the spi should be needed land in rk3036 dts.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6


Thanks
Heiko
