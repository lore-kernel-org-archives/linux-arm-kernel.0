From: ben@trinity.fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 01:48:41 +0100
Subject: [PATCH v2 0/5] HP iPAQ RX1950 patch series
In-Reply-To: <1273560911-18153-1-git-send-email-anarsoul@gmail.com>
References: <1273560911-18153-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20100512004841.GJ6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 09:55:06AM +0300, Vasily Khoruzhick wrote:
> Following patch series add suport for iPAQ RX1950 PDA - another s3c2442-based
> machine. Almost all drivers for this machine are included in mainline kernel,
> and port only lacks battery, LED, WiFi and sound support, they will be added
> later.
> 
> v2: removed unnecessary mappings
> 	use loop for gpio pin configuration
> 	fix key table formating
> 	WARN_ON() the result of gpio_request()

Merged into for-2635/rx1950 and into next-samsung from there.

Have not merged the mainatainers update as it should probably go
to linux-kernel list.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
