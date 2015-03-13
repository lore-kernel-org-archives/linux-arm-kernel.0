From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Mar 2015 10:10:56 -0700
Subject: [PATCH 01/10] pm: domains: quieten down generic pm domains
In-Reply-To: <E1YWSMq-0006Ft-9z@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Fri, 13 Mar 2015 16:23:20 +0000")
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSMq-0006Ft-9z@rmk-PC.arm.linux.org.uk>
Message-ID: <7hy4n0rffj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> PM domains are rather noisy; scheduling behaviour can cause callbacks
> to take longer, which causes them to spit out a warning-level message
> each time a callback takes a little longer than the previous time.
> There really isn't a need for this, except when debugging.
>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>
