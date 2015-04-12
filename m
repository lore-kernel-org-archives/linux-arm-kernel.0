From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 12 Apr 2015 16:58:57 +0200
Subject: Fwd: Re: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink
 DNS-327L
In-Reply-To: <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
References: <b6534b962d2cf9d21cb72d43f19a6574@mail.ncrmnt.org>
 <552A6209.9040903@gmail.com>
 <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
Message-ID: <20150412145857.GA14038@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Okay, got it.
> I'll file a bug about this issue to the the bugzilla. However something
> tells me it might not be cpuidle, but D-link. This one's sounds nasty
> and it has been around since 3.16.x. How could it go unnoticed?
> Unfortunately I have no other armada-370 hardware to test it.

Hi Andrew

A few of us here do have hardware to test with. Please give a detailed
description of how you reproduce the issue, and your kernel
configuration, if different from mvebu_v7_defconfig, or
multi_v7_defconfig.

	Thanks
		Andrew
