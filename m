From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 16 May 2012 17:51:57 +0200
Subject: [PATCH 0/2] ARM: at91: allow all boards to use atmel-mci driver 
Message-ID: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches depends on 'mmc: atmel-mci: add support for old mci IPs'
which allows to use atmel-mci driver on all boards. So keeping at91-mci only
for old chips is no more necessary.
If there are no issues with this new atmel-mci driver, at91-mci driver will be
removed for 3.7 release.


Regards

Ludovic
