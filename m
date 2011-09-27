From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 11:37:52 -0700
Subject: [PATCH v3 5/6] OMAP: omap_device: Create a default
	omap_device_pm_latency
In-Reply-To: <87hb3xzvmo.fsf@ti.com>
References: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
	<1317143886-13285-6-git-send-email-b-cousson@ti.com>
	<20110927173048.GM6324@atomide.com> <87hb3xzvmo.fsf@ti.com>
Message-ID: <20110927183752.GN6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110927 10:56]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Isn't this racey between devices if the latency values get adjusted
> > automatically for each device?
> 
> A copy of this is made for each device (uses kmemdup later in the patch.)

Oh ok, sorry for the noise.

Tony
