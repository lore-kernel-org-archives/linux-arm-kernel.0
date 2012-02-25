From: kevin.wells@nxp.com (Kevin Wells)
Date: Sat, 25 Feb 2012 01:26:37 +0100
Subject: [PATCH v2 2/2] GPIO: LPC32xx: Add output reading to GPO P3
In-Reply-To: <1329845828-26497-2-git-send-email-stigge@antcom.de>
References: <1329845828-26497-1-git-send-email-stigge@antcom.de>
 <1329845828-26497-2-git-send-email-stigge@antcom.de>
Message-ID: <083DF309106F364B939360100EC290F81F30D7F482@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>The chip offers the function to detect the current state of output of the GPO
>P3 pins. Useful for reading GPIO output state in Linux' GPIO API, e.g. via
>sysfs
>
>Signed-off-by: Roland Stigge <stigge@antcom.de>
>

I hate to be picky on this one, but can a comment be added that this only
reads the programmed output state and not the actual state of the pin?
(Unfortunately) GPO pins have no method to monitor their actual output
state.
