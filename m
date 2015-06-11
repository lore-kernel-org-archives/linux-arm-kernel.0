From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:22:18 -0700
Subject: [PATCH] ARM: ep93xx: simone: support for SPI-based MMC/SD cards
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D883D49222D@P3PWEX4MB008.ex4.secureserver.net>
 (Hartley Sweeten's message of "Tue, 9 Jun 2015 01:01:31 +0000")
References: <1433769759-6414-1-git-send-email-linus.walleij@linaro.org>
 <DC148C5AA1CEBA4E87973D432B1C2D883D49222D@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <7h7fradjp1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hartley Sweeten <HartleyS@visionengravers.com> writes:

> On Monday, June 08, 2015 6:23 AM, Linus Walleij wrote:
>> From: Mika Westerberg <mika.westerberg@iki.fi>
>>
>> This includes setting up EGPIOs 0 and 9 for card detection and
>> chip select respectively. This patch is needed to mount a root
>> filesystem on the SPI-based MMC card reader found on the Sim.One.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied to next/soc with Hartley's reviewed-by,

Thanks,

Kevin
