From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 May 2011 17:06:28 +0300
Subject: [PATCH] OMAP3: set the core dpll clk rate in its set_rate
	function.
In-Reply-To: <alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
References: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
	<alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
Message-ID: <20110513140625.GL5323@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110513 05:13]:
> On Mon, 9 May 2011, Avinash.H.M wrote:
> 
> > The debug l3_ick/rate is not displaying the actual rate of the clock in
> > hardware. This is because, the core dpll set_rate function doesn't update the
> > clk.rate. After fixing, the l3_ick/rate is displaying proper values.
> > 
> > Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Wamsley <paul@pwsan.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, let's see if we can get this into an -rc.

Might be out of time as we still should have this sit in
for-next too. Anyways, adding into devel-fixes.

Tony
