From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 05:31:40 -0700
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
Message-ID: <20110627123140.GP23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Premi, Sanjeev <premi@ti.com> [110627 05:08]:
> > From: Tony Lindgren [mailto:tony at atomide.com] 
> > 
> > I don't think omap3_beagle_init_rev is even called when
> > the timer is set?
> 
> [sp] I verified the patch based on the print indicating that
>      GPTIMER1 being used as clockevent source.
>      http://marc.info/?l=linux-omap&m=130893319726456&w=2

I suspect the test always fails though, so it probably never
gets set to gptimer12 on any board :)

Tony
