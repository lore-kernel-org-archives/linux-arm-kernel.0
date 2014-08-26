From: ipaton0@gmail.com (Iain Paton)
Date: Tue, 26 Aug 2014 14:11:51 +0100
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <20140825101832.GT30401@n2100.arm.linux.org.uk>
References: <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435774FD@ALVA-EXMB04.alv.autoliv.int>
 <20140825101832.GT30401@n2100.arm.linux.org.uk>
Message-ID: <53FC8797.1030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/14 11:18, Russell King - ARM Linux wrote:
> On Wed, Aug 13, 2014 at 01:39:27PM +0000, Mattis Lorentzon wrote:
>> All our tests seem to behave the same way on the Sabrelite as on our own board.
>> A working theory is that the switch (3Com Switch 4400) triggers the degeneration
>> of the network stack from which Linux does not seem to recover, even if we later
>> bypass the switch and directly connect the board to the server machine.
> 
> Please can you try something - what happens if you completely disable
> pause frame support (flow control) on all machines on the switch?

Russell, while trying to duplicate this I have flow-control disabled 
on the switch which leads to it being auto-negotiated off on all devices.
Do you think it could be worth turning it on and trying again?
