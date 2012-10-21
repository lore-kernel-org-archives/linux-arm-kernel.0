From: josh.coombs@gmail.com (Josh Coombs)
Date: Sat, 20 Oct 2012 20:08:20 -0400
Subject: Which kirkwood does your DT board use?
In-Reply-To: <20121020113800.GC21046@lunn.ch>
References: <20121020113800.GC21046@lunn.ch>
Message-ID: <CAMW5UfYJv0BAP00wcUd2-mSQo_zv8ibTRZDJ6NqtHQSYAEH7ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2012 at 7:38 AM, Andrew Lunn <andrew@lunn.ch> wrote:
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
> Thanks
>         Andrew

Seagate GoFlexNet
[jcoombs at alarm ~]$ dmesg | grep -i tclk
[    5.851008] Kirkwood: MV88F6281-A0, TCLK=200000000.

Joshua Coombs
