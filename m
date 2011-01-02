From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 Jan 2011 21:33:34 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20101231215018.GB5012@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20101223001012.GF29368@n2100.arm.linux.org.uk>
	<AANLkTimirgsuoM2che_ocrkvCZqGu6xEJjrjdmt9-69p@mail.gmail.com>
	<AANLkTikP+JZkN7AjqaNfHY8jZ7bVsV-af=YR=MTdfnNU@mail.gmail.com>
	<20101231215018.GB5012@n2100.arm.linux.org.uk>
Message-ID: <AANLkTiktQbR5cm6qKzrhCBEMqmxOq4WhryoZnQ-kge0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> So, given all these questions (some of which can lead to deadlocks), and
> we're now at -rc8, I see no way that I can sanely (or safely) queue up
> the PL011 UART and PL180 MMCI DMA engine code for this coming merge
> window. ?(Sorry Linus.)

Such is life, I am still very happy that you have been taking some
time to dive into this. I will try to work through the points raised
as far as I can...

As for the in-tree PL08x driver I'd say it's doing pretty well for
memcpy() so we could add platform data for that on supported
platforms, then for device transfers we need more elaborative
work.

I will also try to get the Nomadik 8815 up to get some reference
HW for this combo that actually works, including device transfers on
MMCI etc.

Yours,
Linus Walleij
