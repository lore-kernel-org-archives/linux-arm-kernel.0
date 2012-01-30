From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jan 2012 10:10:43 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120127171653.GI13504@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
 <20120126093610.GD2287@S2101-09.ap.freescale.net>
 <20120126175122.GX22818@atomide.com>
 <20120127071944.GC32740@S2101-09.ap.freescale.net>
 <20120127171653.GI13504@atomide.com>
Message-ID: <20120130021041.GB10470@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 09:16:53AM -0800, Tony Lindgren wrote:
...
> I guess the analog we should follow here is clk_get and clk_set_rate,
> except we would have pinconf_set_state with predefined states.
> 
It seems working for cases that we only change pinconf but never pinmux
for different configuration states.  But how would that work for cases
that require mux change for different configuration states?

-- 
Regards,
Shawn
