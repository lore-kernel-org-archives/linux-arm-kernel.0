From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 18:24:43 +0200
Subject: [PATCH v6 1/4] rtc: ac100: support clock-output-names in device
 tree binding
In-Reply-To: <20160819074226.16636-2-wens@csie.org>
References: <20160819074226.16636-1-wens@csie.org>
 <20160819074226.16636-2-wens@csie.org>
Message-ID: <20160831162443.idwfr6efztiwtydd@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2016 at 15:42:23 +0800, Chen-Yu Tsai wrote :
> The ac100 device tree binding specifies the usage of clock-output-names
> to specify the names of its 3 clock outputs. This is needed for orphan
> clock resolution, when the ac100 is probed much later than any clocks
> that consume any of its outputs. This wasn't supported by the driver.
> 
> Add support for this.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v5:
> 
>   - New patch, based on mfd-rtc immutable branch given in
> 
>      http://www.spinics.net/lists/devicetree/msg137991.html
> 
> ---
>  drivers/rtc/rtc-ac100.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
