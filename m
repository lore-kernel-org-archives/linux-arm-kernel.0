From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 May 2011 12:06:18 -0400
Subject: [PATCH v3 0/4] Consolidate sdhci pltfm & OF drivers and get them
	self registered
In-Reply-To: <20110527072647.GE31953@ponder.secretlab.ca> (Grant Likely's
	message of "Fri, 27 May 2011 01:26:47 -0600")
References: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
	<20110527072647.GE31953@ponder.secretlab.ca>
Message-ID: <m3pqn4ruv9.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Fri, May 27 2011, Grant Likely wrote:
> Any chance we can get this series into $NEXT_KERNEL?

I think I'd rather not in this case, hope that's okay.  It hasn't seen
testing in linux-next yet, there's a reasonable chance of it breaking
sdhci-pltfm users in subtle ways -- we haven't had much testing from
the individual -pltfm driver maintainers yet -- and the mmc merge was
(relatively) huge already this cycle.

I'll certainly push it to linux-next as soon as -rc1 is released,
though.  Sound okay?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
