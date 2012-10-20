From: jm@lentin.co.uk (Jamie Lentin)
Date: Sat, 20 Oct 2012 13:11:39 +0100 (BST)
Subject: Which kirkwood does your DT board use?
In-Reply-To: <20121020113800.GC21046@lunn.ch>
References: <20121020113800.GC21046@lunn.ch>
Message-ID: <alpine.DEB.2.00.1210201305070.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Andrew Lunn wrote:

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

DNS-320:-
Kirkwood: MV88F6281-A1, TCLK=166666667

DNS-325:-
Kirkwood: MV88F6281-A1, TCLK=200000000

"compatible" currently says "marvell,kirkwood-88f6281" for both. Is this 
the right string to use or should it be 88f6281-a1?

> Please could you check your hardware and let me know what the correct
> CPU is. I can then fix the .dts files and prepare a first attempt at
> converting boards to pinctrl.

Let me know if I can be useful.

> Thanks
> 	Andrew
>

-- 
Jamie Lentin
