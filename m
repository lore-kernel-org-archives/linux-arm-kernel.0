From: davem@davemloft.net (David Miller)
Date: Wed, 04 Mar 2015 23:33:22 -0500 (EST)
Subject: [PATCH] ARM: fix typos in smc91x platform data
In-Reply-To: <3483843.L07cLWCFPN@wuerfel>
References: <20150228.125721.1605776377351425463.davem@davemloft.net>
 <55454365.1GsbtFBXGk@wuerfel> <3483843.L07cLWCFPN@wuerfel>
Message-ID: <20150304.233322.2161418715687567572.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 04 Mar 2015 23:39:18 +0100

> I recently did a rework of the smc91x driver and did some build-testing
> by compiling hundreds of randconfig kernels. Unfortunately, my script
> was wrong and did not actually test the configurations that mattered,
> so I introduced stupid typos in almost every file I touched.
> 
> I fixed my script now, built all configurations that actually matter
> and fixed all the typos, this is the result.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b70661c70830d ("net: smc91x: use run-time configuration on all ARM machines")

Applied, thanks.
