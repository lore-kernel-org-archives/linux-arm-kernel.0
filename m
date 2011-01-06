From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:45 +0200
Subject: [PATCH 0/7] ARM: S3C24XX: H1940 and RX1950 series
Message-ID: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series improves HP iPAQ H1940 and RX1950 support.

Changes introduced by these patches:
1. Add support for H1940 buttons
2. Compile fix for h1940-bluetooth.c
3. Use leds-gpio to drive LEDs on H1940
4. Add support for battery monitoring and charging on H1940
5. Improve LCD power-on sequence
6. Retain LEDs state on RX1950 in suspend
7. Add support for HW LEDs blinking on RX1950
