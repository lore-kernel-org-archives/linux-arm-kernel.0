From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Apr 2011 22:22:01 +0200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <4D9F2D3F.5010109@linaro.org>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201104081702.17409.arnd@arndb.de> <4D9F2D3F.5010109@linaro.org>
Message-ID: <201104082222.01634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2011, Lee Jones wrote:
> I didn't say we won't need it. I'm just finding it difficult to picture
> how it would work. I'm more than happy to implement it, but there are
> more things to take into consideration, such as naming conventions for
> multiple SoCs. Even if they start at '1' and increase sequentially,
> there are still questions that need to be answered, such as; How will
> the SoCs be ordered? First come first served? Priority order? Or we
> could name them by soc_id?

Any of these would be fine IMHO. In most cases, the order is fixed,
either through a board file or through the order in the device tree,
so I would just use a sequential number.

	Arnd
