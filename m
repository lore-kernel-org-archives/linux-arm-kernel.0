From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 May 2012 13:19:29 -0700
Subject: [PATCH 11/18][V3] ARM: OMAP3: cpuidle - remove the 'valid' field
In-Reply-To: <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:32 +0200")
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87r4v1kofi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> With the previous changes all the states are valid, except
> the last state which can be handled by decreasing the number
> of states.

I don't think this changelog is valid anymore as you're not doing
anything to decrease the number of states.

I updated the changelog locally to this:

ARM: OMAP3: cpuidle - remove the 'valid' field

With the previous changes all the states are valid, except the last
state which is now handled at runtime by next_valid_state() based on
the errata flags.

Any problems with that?

Kevin
