From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 04 Jun 2013 11:34:15 -0700
Subject: [RFC 09/42] drivers/i2c/busses: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-10-git-send-email-wsa@the-dreams.de> (Wolfram
 Sang's message of "Fri, 10 May 2013 10:16:54 +0200")
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-10-git-send-email-wsa@the-dreams.de>
Message-ID: <87txldzpw8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Kevin Hilman <khilman@linaro.org>  # for i2c-omap.c
