From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 11 Jul 2016 21:12:08 -0700
Subject: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
In-Reply-To: <578271D3.4080704@roeck-us.net> (Guenter Roeck's message of "Sun,
 10 Jul 2016 09:03:31 -0700")
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
 <578271D3.4080704@roeck-us.net>
Message-ID: <7hbn237aw7.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Would this go in through one of the arm trees ?

You can take the driver through the watchdog tree, but I'll take the DT
stuff through the amlogic tree (and submit via arm-soc).  

However, with your ack, and since this is a brand new driver, I could
take the driver as well.  Just let me know your preference.

Thanks,

Kevin
