From: jochen@scram.de (Jochen Friedrich)
Date: Thu, 11 Aug 2011 17:24:58 +0200
Subject: [PATCH 3.2 0/4] ARM: simpad: Add support for GPIO attached
	hardware
In-Reply-To: <1312793379-6020-1-git-send-email-jochen@scram.de>
References: <1312793379-6020-1-git-send-email-jochen@scram.de>
Message-ID: <4E43F44A.1000509@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2011 10:49, Jochen Friedrich wrote:

> This series enables GPIO API on UCB1x00 and implements the GPIO
> API on the CS3 latch. The third patch finally registers platform
> devices for the GPIO attached LED, buttons and I2C bus.
>
> ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
> ARM: simpad: Cleanup CS3 accessors and add GPIO API
> ARM: simpad: add GPIO based device definitions
> ARM: simpad: replace ARM specific LED code

ping.

Did someone have time to look at this yet?

Thanks,
Jochen
