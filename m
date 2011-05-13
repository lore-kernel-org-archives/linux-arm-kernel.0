From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 12 May 2011 20:17:17 -0600 (MDT)
Subject: [PATCH] OMAP3: set the core dpll clk rate in its set_rate
	function.
In-Reply-To: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
References: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
Message-ID: <alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 May 2011, Avinash.H.M wrote:

> The debug l3_ick/rate is not displaying the actual rate of the clock in
> hardware. This is because, the core dpll set_rate function doesn't update the
> clk.rate. After fixing, the l3_ick/rate is displaying proper values.
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Wamsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Thanks, let's see if we can get this into an -rc.


- Paul
