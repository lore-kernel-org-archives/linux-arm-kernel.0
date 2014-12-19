From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 19 Dec 2014 13:49:34 -0800
Subject: [PATCH 4/4] PM: Eliminate CONFIG_PM_RUNTIME
In-Reply-To: <9470157.PyHoGoSGz1@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Fri, 19 Dec 2014 22:41:54 +0100")
References: <472992175.g1ArEYGFPo@vostro.rjw.lan>
 <2635409.SWsBMlb9s4@vostro.rjw.lan>
 <CAMuHMdUn3KSTdh4nFL=G54SM7NWpQsmeg1GYYRz=+uXH9rbEGg@mail.gmail.com>
 <9470157.PyHoGoSGz1@vostro.rjw.lan>
Message-ID: <7h1tnv2tu9.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

[...]

> Fixed up patch is appended, thanks!
>
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: PM: Eliminate CONFIG_PM_RUNTIME
>
> Having switched over all of the users of CONFIG_PM_RUNTIME to use
> CONFIG_PM directly, turn the latter into a user-selectable option
> and drop the former entirely from the tree.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

I assume you're planning to get this in early in the v3.19-rc cycle,
correct?  That way we can hopefully avoid conflicts with the various
defconfig changes we're taking through the arm-soc tree.

Also, thanks for taking care of all the tree-wide changes.  This is a
great change.

Kevin
