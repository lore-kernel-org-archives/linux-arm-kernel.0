From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 09 Aug 2011 19:25:14 +0200
Subject: [PATCH 2/3 v2] RFC: arm/kirkwood: add dreamplug support.
In-Reply-To: <6b9e805f5765939fc844d5a9cd02ad141aa6af00.1312906908.git.jason@lakedaemon.net>
	(Jason Cooper's message of "Tue, 9 Aug 2011 16:47:32 +0000")
References: <cover.1312906908.git.jason@lakedaemon.net>
	<cover.1312906908.git.jason@lakedaemon.net>
	<6b9e805f5765939fc844d5a9cd02ad141aa6af00.1312906908.git.jason@lakedaemon.net>
Message-ID: <87ei0uebut.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

Hi,

> Copied guruplug-setup.c and did s/guruplug/dreamplug/g.  Then, switched
> to SPI based NOR flash.  LED pins are correct.

Why don't use modify guruplug.c instead and use some if (machine_is_*)
tests to handle the differences like what was done for openrd ? I find
it quite wasteful to add a new machine file while (I guess) it should be
easier to modify existing code.

Regards,
Arnaud
