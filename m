From: khilman@ti.com (Kevin Hilman)
Date: Wed, 31 Aug 2011 15:30:35 -0700
Subject: [PATCH 6/7] OMAP: omap_device: Create a default
	omap_device_pm_latency
In-Reply-To: <1314026347-21623-7-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:06 +0200")
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-7-git-send-email-b-cousson@ti.com>
Message-ID: <87zkip6wok.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Most devices are using the same default omap_device_pm_latency structure
> during device built. In order to avoid the duplication of the same
> structure everywhere, add a default structure that will be used if
> the device does not have an explicit one.
>
> Next patches will clean the duplicated structures.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Excellent, queuing this for v3.2 (branch: for_3.2/omap_device)

Kevin
