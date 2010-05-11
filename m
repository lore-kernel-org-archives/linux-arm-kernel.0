From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 11 May 2010 09:55:06 +0300
Subject: [PATCH v2 0/5] HP iPAQ RX1950 patch series
Message-ID: <1273560911-18153-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following patch series add suport for iPAQ RX1950 PDA - another s3c2442-based
machine. Almost all drivers for this machine are included in mainline kernel,
and port only lacks battery, LED, WiFi and sound support, they will be added
later.

v2: removed unnecessary mappings
	use loop for gpio pin configuration
	fix key table formating
	WARN_ON() the result of gpio_request()
