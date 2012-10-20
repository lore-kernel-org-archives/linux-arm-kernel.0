From: gmbnomis@gmail.com (Simon Baatz)
Date: Sat, 20 Oct 2012 20:47:50 +0200
Subject: Which kirkwood does your DT board use?
In-Reply-To: <20121020113800.GC21046@lunn.ch>
References: <20121020113800.GC21046@lunn.ch>
Message-ID: <20121020184750.GA19620@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sat, Oct 20, 2012 at 01:38:00PM +0200, Andrew Lunn wrote:
> Hi Folks
> 
> All of you in the To: have contributed a DT based Kirkwood board port.
> Nearly all the DT files we have declare the CPU to be
> marvell,kirkwood-88f6281. For adding DT based pinctrl, to replace the
> mpp code, we need to know the exact kirkwood being used. It should be
> one of MV88F6180, MV88F6190, MV88F6192, MV88F6281 or MV88F6282.
> 
> You can see what your hardware has a boot time:
> 
> Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.
> 
> Please could you check your hardware and let me know what the correct
> CPU is. I can then fix the .dts files and prepare a first attempt at
> converting boards to pinctrl.
> 

My IB-NAS6210 says:

Kirkwood: MV88F6281-A1, TCLK=200000000.

I don't have a 6220, but I suppose it is the same since they seem to
use the same board internally.

- Simon
