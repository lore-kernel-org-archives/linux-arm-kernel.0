From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 21:25:55 +0200
Subject: [PATCH 2/4] arm64: Initial defconfig for APM X-Gene SOC family
In-Reply-To: <20130422173116.GD9602@arm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <2165570.9Zy5vrhoIa@wuerfel> <20130422173116.GD9602@arm.com>
Message-ID: <201304222125.55220.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Catalin Marinas wrote:
> That's good as we can get any automatic builds using defconfig to test
> all the platforms. The only issue I see is that as the number of SoCs
> grows, if you only need to select a single SoC you could end up with
> features enabled for other platforms.

I don't see that as a problem, as long as the defconfig just works for
everyone. Anyone building an embedded system can just disable the drivers
they don't need.

	Arnd
