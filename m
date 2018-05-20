From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:56:24 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
In-Reply-To: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
References: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
Message-ID: <20180520125623.GY26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 09:39:21AM +0300, Nikita Yushchenko wrote:
> Vybrid has single internal temperature sensor connected to both internal
> ADC modules.
> 
> vf610-zii-dev already has ADC0 enabled. Now, to get temperature sensor
> captured by iio_hwmon driver, need to configure iio_hwmon node to use
> that ADC.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied, thanks.
