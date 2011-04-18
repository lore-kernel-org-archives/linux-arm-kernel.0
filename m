From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 18 Apr 2011 09:19:02 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
Message-ID: <20110418091902.13345132@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> gpiolib handles input and output, high and low because that's all that could reasonably be expected to a) always work and b) be changed at run time in the driver.

Imagine if file systems only handled 8.3 filenames because that's all
that could reasonably be expected to a) always work !

> So in short - what's the use case?  Which driver requires this?
> 

Also your comment re simply in or out on or off is incorrect. Pins may
also be in use by firmware and the like and in a 'neither' state.
Something certain gpio people seem to be in denial over.

Alan
