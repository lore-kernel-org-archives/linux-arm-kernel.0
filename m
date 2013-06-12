From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Jun 2013 14:27:13 +0100
Subject: [PATCH 00/32] ARM: ux500: Enable clocks for Device Tree
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130612132713.GE4320@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> After this patchset has been applied, we can request clocks directly
> from Device Tree without using any AUXDATA device-name hacks. We also
> take care to remove all of thos at the end of the set.

So it looks like Mike and Grant have okayed the actual design of this
patch-set, which is great. Is there any chance on some proper Acks from
Linus and Mike please?

I guess it would be best if this went in via Linus' tree as a compete
patch-set?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
