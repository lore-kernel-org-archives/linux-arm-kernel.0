From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 14 May 2014 21:44:38 -0700
Subject: [PATCH] watchdog: sp805: Set watchdog_device->timeout from
 ->set_timeout()
In-Reply-To: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
References: <c78a7ad282aff9bd1b88c55c2590438e17ef95e1.1400127943.git.viresh.kumar@linaro.org>
Message-ID: <53744636.8080104@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 09:31 PM, Viresh Kumar wrote:
> Implementation of ->set_timeout() is supposed to set 'timeout' field of 'struct
> watchdog_device' passed to it. sp805 was rather setting this in a local
> variable. Fix it.
>
> Cc: <stable@vger.kernel.org> # 2.6.36+
> Reported-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
