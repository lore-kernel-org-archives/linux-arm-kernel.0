From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri,  9 Jul 2010 14:27:19 +0300
Subject: [PATCH 0/3] s3c24xx: iPAQ rx1950 series
Message-ID: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds more support for iPAQ rx1950 PDA to linux:
1. LEDs driver -- it controls blue, green and red LEDs on rx1950
2. Battery driver -- adds ability to monitor and charge battery.
This driver is suitable for H1940 PDA aswell (just need to write
some machine specific callbacks and get voltage LUTs)
