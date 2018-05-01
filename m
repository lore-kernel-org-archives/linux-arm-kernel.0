From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 19:39:56 +0530
Subject: [PATCH v9 04/27] ARM: davinci: pass clock as parameter to
 davinci_timer_init()
In-Reply-To: <20180427001745.4116-5-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-5-david@lechnology.com>
Message-ID: <29a9a03c-93f5-dddf-2a6e-da7fd83e0c4f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This changes davinci_timer_init() so that we pass the clock as a
> parameter instead of using clk_get(). This is done in preparation
> for converting to the common clock framework.
> 
> It removes the requirement that we have to have a clock with con_id
> of "timer0", which will be good for DT bindings since clock-names =
> "timer0" doesn't really make sense.
> 
> Also, drop use of extern in header file since we are touching the
> definition.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
