From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Feb 2016 12:28:08 -0700
Subject: [PATCH v2] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
References: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
Message-ID: <56D0A748.6060104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 12:18 PM, Lucas Stach wrote:
> Update pinmux to get rid of invalid uses of the rsvd1 function, which lead
> to the mux settings on those pins to not be applied.
>
> Also add correct drive settings, derived from the Tegra3 TRM, for SDIO1,
> which makes some more SD-cards work.

I replied the following to V1, which I don't see resolved:

 > I think it would be worth mentioning in the commit description where 
 > this[1] data came from.

[1] that was in response to the addition of the sdio1 drive settings.

Also, what is different in V2; is this actually V1 REPOST?
