From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Feb 2011 09:26:12 +0000
Subject: [PATCH] ARM: Thumb-2: Enable ARM/Thumb interworking for v7 cache
	maintenance
In-Reply-To: <20110215180058.GS4152@n2100.arm.linux.org.uk>
References: <1297792565-30401-1-git-send-email-dave.martin@linaro.org>
	<20110215180058.GS4152@n2100.arm.linux.org.uk>
Message-ID: <AANLkTims4DDAP8nLZELLMWKh72AZCU8M3kPNqDFEuppQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 6:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 05:56:05PM +0000, Dave Martin wrote:
>> Cache maintenence functions may need to be called from low-level
>> platform code (such as for omap3).
>
> I'd rather wait until we have the suspend stuff sorted out. ?I'm
> waiting for OMAP folk to sort out what's happening with the sleep*.S
> code so that it can have the generic CPU suspend code integrated.
> That could result in this change not being required.
>

OK; I guess we can work around this in the omap BSP for the time being.

---Dave
