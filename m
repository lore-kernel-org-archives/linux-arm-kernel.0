From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 11:25:22 +0200
Subject: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
In-Reply-To: <20120906205227.GM1303@atomide.com>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
 <20120906205227.GM1303@atomide.com>
Message-ID: <504DB202.5050500@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/09/2012 22:52, Tony Lindgren a ?crit :
> * Florian Vaussard <florian.vaussard@epfl.ch> [120831 09:07]:
>> The Gumstix Overo is a computer on module using an OMAP3 processor.
>> This module must be plugged into an expansion board.
>>
>> This patchset adds a first device tree support for the Overo, using the
>> Tobi expansion board. The current support is able to boot and mount
>> the rootfs from MMC, with a few extra features.
>>
>> The first patch creates the device tree for both the Overo and the
>> Tobi expansion board, and updates the dtb build target.
>>
>> The second patch updates the omap/dts documentation.
>>
>> This patchset applies on tony's tree [1], devel-dt branch.
> Great, I'm assuming Benoit will pick this up as well.

What is the status Benoit?

Thank you,
Florian
