From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 16 May 2012 15:25:57 +0200
Subject: [PATCH 0/4] mmc: atmel-mci: add support for old mci IPs
Message-ID: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches is an extra step to remove at91-mci dirver which is mainly
used for old chips having mci IPs whose version is lesser than v2xx (rm9200
and 9261).
Since it introduces many changes and there was a lack of logs to help people
when there is an issue with atmel-mci driver, I added some debug logs.

These changes have been tested on at91rm9200, at91sam9261, at91sam9263,
at91sam9g10 and at91sam9g45.


Regards

Ludovic
