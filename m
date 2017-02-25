From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 25 Feb 2017 09:42:37 +0200
Subject: [PATCH 5/7] watchdog: s3c2410: Constify local structures
In-Reply-To: <7100fd29-a21d-25c0-b989-644e1358b34b@roeck-us.net>
References: <20170224210746.12459-1-krzk@kernel.org>
 <20170224210746.12459-5-krzk@kernel.org>
 <7100fd29-a21d-25c0-b989-644e1358b34b@roeck-us.net>
Message-ID: <20170225074237.txpetwb6e5p4bqyt@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 02:05:56PM -0800, Guenter Roeck wrote:
> On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> > Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
> > modified so they can be made const to increase code safeness.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Conflicts with "watchdog: constify watchdog_ops structures" in my tree.
> I rebased my tree to v4.10 (which I should not really have done ;-), but
> it still doesn't apply due to "fatal: sha1 information is lacking or useless"
> and "error: could not build fake ancestor". The subsequent patches also don't
> apply. You may have to wait until after -rc1, rebase your patches, and
> resubmit.

Sure, I'll resend after merge window. These aren't important fixes so
there is no problem in waiting for merge window to end.

Thanks for reviews.

Best regards,
Krzysztof
