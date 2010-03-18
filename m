From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Thu, 18 Mar 2010 10:10:16 -0400
Subject: devicetree in arm
In-Reply-To: <fa686aa41003180654y56b8ea4elee3c13590b896c5a@mail.gmail.com>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
	<fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
	<20100318132358.GE19544@n2100.arm.linux.org.uk>
	<fa686aa41003180654y56b8ea4elee3c13590b896c5a@mail.gmail.com>
Message-ID: <d91d07041003180710t243403e9g18ef3704d1f2b2fd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm also interested in the Device Tree for ARM.

We're planning on having several devices with the same basic
layout, but several stuffing options. It would be preferable
to have a Device Tree blob that the bootloader can pass to
a generic kernel, instead of allocating several ARM Machine
IDs, one for each layout.

I've been watching these threads, and am eager to start
using the combined infrastructure once it becomes widely
available.

--
Jason McMullan
Netronome Systems
