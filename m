From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 13:38:00 +0200
Subject: Which kirkwood does your DT board use?
Message-ID: <20121020113800.GC21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

All of you in the To: have contributed a DT based Kirkwood board port.
Nearly all the DT files we have declare the CPU to be
marvell,kirkwood-88f6281. For adding DT based pinctrl, to replace the
mpp code, we need to know the exact kirkwood being used. It should be
one of MV88F6180, MV88F6190, MV88F6192, MV88F6281 or MV88F6282.

You can see what your hardware has a boot time:

Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.

Please could you check your hardware and let me know what the correct
CPU is. I can then fix the .dts files and prepare a first attempt at
converting boards to pinctrl.

Thanks
	Andrew
