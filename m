From: dv@vollmann.ch (Detlef Vollmann)
Date: Thu, 10 Dec 2015 13:56:05 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <87wpsz61r7.fsf@free-electrons.com>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com> <87wpsz61r7.fsf@free-electrons.com>
Message-ID: <56697665.1070609@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/15 14:43, Gregory CLEMENT wrote:
>> Detlef, Benjamin,
>>
>> could you test it on an Orion5x based board?
Ok, I tested the v2 series on v4.4-rc3 on my
DNS-323: Identified HW revision B1
Orion ID: MV88F5182-A2. TCLK=166666667.

Only basic tests, serial port and network.

The good news:
orion5x_defconfig works and is even slightly smaller than the
original v4.4-rc3 kernel image.

The bad news:
My own config (which is massivly stripped down) produces a kernel
image that's more than 26K bigger than on v4.4-rc3 without any
added functionality.
The DNS-323 is extremly constrained in space (the whole system
including boot loader, kernel and filesystem has to fit into 8M flash).
Any ideas how I can get rid of this additional overhead?

  Detlef
