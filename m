From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 19 Apr 2013 15:44:19 -0700
Subject: [V3 patch 00/19] cpuidle: code consolidation
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Fri, 12 Apr 2013 14:35:46 +0200")
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <8761ziw37g.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset series provide some code consolidation across the different
> cpuidle drivers. It contains two parts, the first one is the removal of
> the time keeping flag and the second one, is a common initialization routine.

[...]

> Tested-on: u8500
> Tested-on: at91
> Tested-on: intel i5
> Tested-on: OMAP4

Tested-by: Kevin Hilman <khilman@linaro.org> # OMAP3, OMAP4

Kevin
