From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 30 Jan 2014 22:10:49 -0800
Subject: [PATCH] ARM: integrator: restore static map on the CP
In-Reply-To: <1390568668-32270-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Fri, 24 Jan 2014 14:04:28 +0100")
References: <1390568668-32270-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <87d2j8vfyu.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Commit 78d1632183454dba46ca8295484a5e7603acdc18 deleted the
> static mappings of the core modules, but this static map is
> still needed on the Integrator/CP (not the Integrator/AP).
>
> Restore the static map on the Integrator/CP.
>
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this fix directly to ARM SoC
> if you're OK with it.

Queuing for fixes.

Kevin
