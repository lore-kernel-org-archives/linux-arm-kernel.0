From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jun 2015 11:19:14 +0200
Subject: RCU stall in af_unix.c, should use spin_lock_irqsave?
In-Reply-To: <6E9AD71A-9E19-437F-A94B-D8B267F533EA@opengear.com>
References: <6E9AD71A-9E19-437F-A94B-D8B267F533EA@opengear.com>
Message-ID: <20150616111914.1c00e197@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 Jun 2015 19:17:50 +1000, Ken Wilson wrote:

> We?re running into this issue (stall on the on_each_cpu call in mvpp2) on our customer?s Armada 375 platform
> Did you make any progress with fixes to the mvpp2 driver?

We do have some patches, but there are still not fixing the problem
entirely, unfortunately. This is a topic to which we need to put some
effort. I'll have a look at what we can do.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
