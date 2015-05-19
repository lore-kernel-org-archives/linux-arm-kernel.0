From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Tue, 19 May 2015 11:52:16 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <20150519111402.747e8eb2@bbrezillon>
References: <55559D55.6020703@aksignal.cz>	<20150515172516.005e3a21@bbrezillon>	<5559865F.9010502@aksignal.cz>	<20150518092750.449d6c8c@bbrezillon>	<5559A029.9060007@aksignal.cz>	<555AA8F1.80100@atmel.com>	<20150519091442.675b1a98@bbrezillon>	<555AFBFD.3010506@aksignal.cz>
 <20150519111402.747e8eb2@bbrezillon>
Message-ID: <555B07D0.4030000@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19.5.2015 11:14, Boris Brezillon wrote:
>
> There's a difference between your heartbeat (the frequency you
> refresh/reset your watchdog) and the watchdog expiration time (here set
> to 16 secs).
> We usually set the heartbeat to 1/2 or 1/4 the expiration time, so that
> we're (almost) sure we can reset the watchdog before its expiration.
>
>
I'm confused. Why need kernel to know the time in witch userspace process will reset watchdog?
And how to change watchdog expiration time?
