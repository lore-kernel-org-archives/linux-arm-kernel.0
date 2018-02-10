From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 10 Feb 2018 15:29:41 +0100
Subject: [PATCH v2 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180210091911.3644-1-marcus.folkesson@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
Message-ID: <20180210142940.GA2452@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2018 at 10:19:05 +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
