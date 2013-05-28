From: john.stultz@linaro.org (John Stultz)
Date: Tue, 28 May 2013 13:34:19 -0700
Subject: [PATCH 1/2] clocksource: dw_apb: remove unused header
In-Reply-To: <1369570367-994-1-git-send-email-baruch@tkos.co.il>
References: <1369570367-994-1-git-send-email-baruch@tkos.co.il>
Message-ID: <51A514CB.7090808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2013 05:12 AM, Baruch Siach wrote:
> The time.h header seems not to be used by current code. Removing this include
> allows the driver to build on other architecture that do not have this header.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
I've gone ahead and queued this for 3.11

thanks
-john
