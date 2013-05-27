From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 27 May 2013 13:07:53 +0100
Subject: [PATCH 1/2] clocksource: dw_apb: remove unused header
In-Reply-To: <1369570367-994-1-git-send-email-baruch@tkos.co.il>
References: <1369570367-994-1-git-send-email-baruch@tkos.co.il>
Message-ID: <20130527120753.GB3048@maple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 03:12:46PM +0300, Baruch Siach wrote:
> The time.h header seems not to be used by current code. Removing this include
> allows the driver to build on other architecture that do not have this header.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jamie Iles <jamie@jamieiles.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>
