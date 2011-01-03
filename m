From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Mon, 3 Jan 2011 21:55:11 +0200
Subject: ks8695_gettimeoffset
In-Reply-To: <4D18B2B5.5000001@visionsystems.de>
References: <4D0FA9FB.3060309@softplc.com>
	<20101220193049.GI28157@n2100.arm.linux.org.uk>
	<4D18B2B5.5000001@visionsystems.de>
Message-ID: <AANLkTi=+9h20je24F+pnoZRFE-of-VZ5Xax8-tDzFs4=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Is it possible at all to implement clocksource/clockevents for KS8695? As Dick and "Register Description" already said you cannot read the time register, so clocksource->read cannot be implemented to return ticks elapsed. Or do I see it wrong?

I'm pretty sure I tested this when I originally submitted the KS8685
processor support (May 2007), and the timer registers are readable.
I would of tested with a userspace program that sat in a tight loop
calling gettimeofday().


Regards,
  Andrew Victor
