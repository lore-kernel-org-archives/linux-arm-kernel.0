From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 19:27:00 +0000
Subject: [PATCH 0/6] ARM: mxs: remove board files
In-Reply-To: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201208071927.01071.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Shawn Guo wrote:
> 
> The first two patches hack out the board oddness in DT boot for TX28
> and MX28EVK, so that they do not block the whole progress of coverting
> mxs platform over to DT.
> 
> The rest of the series removes board files and the codes only used in
> non-DT boot, and make mxs a DT-only platform.

So it has come to this ;-)

Great job Shawn and everyone else who was involved in this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
