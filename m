From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 Aug 2016 21:33:25 +0800
Subject: [PATCH 1/2] ARM: dts: imx7s-warp: Add MPL3115 sensor support
In-Reply-To: <1470768046-28416-1-git-send-email-breno.lima@nxp.com>
References: <1470768046-28416-1-git-send-email-breno.lima@nxp.com>
Message-ID: <20160815133325.GG500@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 03:40:45PM -0300, Breno Lima wrote:
> Add support for MPL3115 NXP pressure sensor.
> 
> Tested by reading temperature and pressure:
> 
> $ cat /sys/bus/iio/devices/iio:device0/in_temp_raw
> $ cat /sys/bus/iio/devices/iio:device0/in_pressure_raw
> 
> Signed-off-by: Breno Lima <breno.lima@nxp.com>

Applied both, thanks.
