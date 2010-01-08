From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 06:32:27 +0000
Subject: GPIO update to allow code to get at gpio_chip
Message-ID: <1262932348-2888-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allowing gpiolib implementations to get at the gpio_chip from the
gpio number is useful to allow gpiolib gpio numbering to be used
for other gpio purposes such as changing pin configuration.

The following patch exports this information. A patch showing the
reason for my wanting this can be supplied on request.
