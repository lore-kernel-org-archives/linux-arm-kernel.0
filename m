From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Oct 2017 13:56:24 +0000
Subject: [PATCH 0/3] crypto: marvell - Remove the old CESA driver
In-Reply-To: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
References: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
Message-ID: <20171011135624.GL31762@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Boris,

On Wed, Oct 11, 2017 at 03:16:16PM +0200, Boris Brezillon wrote:
> Hello,
> 
> It's been several releases since we added a new driver to support the
> CESA IP (the new driver was introduced in 4.2). It seems most major
> bugs have been discovered and fixed and now is probably a good time to
> kill the old driver and force remaining users to switch to the new one.
> 
> This series first add a platform_device_id table to the marvell CESA
> driver so that it can work on non-DT platforms. Then we patch all
> defconfigs to select the new driver instead of the old. And finally we
> remove the old driver.
> These patches have to be applied in this order to make things
> bisectable, so, if this series is accepted it will have to go through
> a single tree (either ARM or crypto).

Thanks for keeping this on your radar.  As I was the one who originally
requested this transitioning time,

Acked-by: Jason Cooper <jason@lakedaemon.net>

For the series.

thx,

Jason.
