From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 17:36:11 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120123210052.GS22818@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
Message-ID: <20120126093610.GD2287@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Jan 23, 2012 at 01:00:52PM -0800, Tony Lindgren wrote:
...
> So to summarize: I suggest we'll just stick to basics to get the system
> booting and devices working using device tree. In most cases the device
> drivers should be able to configure the suspend and off states in a generic
> way using pinctrl API. Everything else, like debugging, we can probably
> do with userspace tools.
> 
> This would mean just using a minimal subset of your binding, probably
> very close to what you originally suggested.
> 
IMHO, as a generic device tree binding, it should be able to cope with
different use cases.  It's really free for you to use the minimal
subset of the binding as your need, but we should not make the binding
design just be that minimal subset to force that everyone else can
only use the minimal subset.

-- 
Regards,
Shawn
