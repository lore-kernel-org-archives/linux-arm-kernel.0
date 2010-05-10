From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 10 May 2010 23:43:09 +0300
Subject: [PATCH 0/5] HP iPAQ RX1950 patch series
Message-ID: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following patch series add suport for iPAQ RX1950 PDA - another s3c2442-based
machine. Almost all drivers for this machine are included in mainline kernel,
and port only lacks battery, LED, WiFi and sound support, they will be added
later.

Ben, if you don't like 5th patch - just drop it, but I think that simplier
solution is almost always the best :)
