From: therealbadguy@gmail.com (Chris)
Date: Sun, 30 Jan 2011 16:32:47 -0700
Subject: ioremap amba device registers 2.6.28-rc2
Message-ID: <AANLkTikjCM6vw0nFsjO9YqY_=ztzSTpodDhGfLcJG=A+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to ioremap memory from 0xC0000000

I expect it to map me to the registers for the MBX device on the iMX31
Litekit from LogicPD
on 2.6.19.2 with some out of tree freescale patches it works.

Could there be other code to initialize this device somewhere in this kernel?
or am I facing some type of memory mapping problem?

I have been trying to learn about this from the ground up, but I am
lost in a sea of information.

is this the right place to request this type of information?

Somewhat of a double post, but I think the previous question will be
ignored for various reasons.

Thanks
