From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Nov 2014 17:29:30 +0100
Subject: [PATCH,
 regression against -rc6] net/stmmac: fix one more regression from
 filter bins setting
In-Reply-To: <5388366.Y15J6TLmlA@wuerfel>
References: <5388366.Y15J6TLmlA@wuerfel>
Message-ID: <4809570.05nXhLpYaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 November 2014 13:03:19 Arnd Bergmann wrote:
> I've sent this off to the build bots, but it will probably take some more
> time before it's been tested on all the ARM machines and I might not be
> there to see the results, so I'm sending it out now for review. I will
> reply once I am sure the problem is fixed.

With this patch applied, both boot bots are back to 100% success now,
all eight failing machines are working again.

	Arnd
