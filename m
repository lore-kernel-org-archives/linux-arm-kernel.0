From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Feb 2014 05:30:25 -0300
Subject: [PATCH v6 01/19] clocksource: orion: Use atomic access for
 shared registers
In-Reply-To: <52F96993.9090007@linaro.org>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F96993.9090007@linaro.org>
Message-ID: <20140211083024.GA3687@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 01:06:43AM +0100, Daniel Lezcano wrote:
> On 02/06/2014 06:20 PM, Ezequiel Garcia wrote:
> > Replace the driver-specific thread-safe shared register API
> > by the recently introduced atomic_io_clear_set().
> >
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Tested-by: Willy Tarreau <w@1wt.eu>
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> The patch looks good for me.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 

Daniel,

Jason acked this patch for you to take it. Or do you prefer that we
merge it with the rest of the watchdog series?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
