From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 20 Mar 2010 20:20:05 +0200
Subject: [PATCH 0/4] HP iPAQ RX1950 patch series
Message-ID: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following patch series add support for iPAQ RX1950 PDA - another s3c2442-based
machine.
Almost all drivers for this machine are included in mainline kernel, and port
only lacks battery, WiFi and sound support, they will be added later.

Port still uses machine-specific GPIO API, as generic GPIO lacks GPJ
support and RX1950 actively uses GPJ port. However I do not see any benifits
in using generic GPIO API in machine support file, as it will not be used
with CPU different from s3c2442.

Denis: I hope you'll add your Signed-off at least under first patch.

I doubt that I can get Signed-off from Victor Chukhantsev, as he doesn't
work on port for a long time. 

Regards,
Vasily
