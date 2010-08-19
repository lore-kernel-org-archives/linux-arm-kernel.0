From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 19 Aug 2010 18:00:00 +0300
Subject: [PATCH 0/3] h1940 series
Message-ID: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces h1940-specific latch-related
functions with gpiolib, fixes compilation error for h1940-bluetooth
and adds PM support for mmc driver.
