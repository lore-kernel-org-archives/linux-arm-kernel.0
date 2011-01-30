From: therealbadguy@gmail.com (Chris)
Date: Sun, 30 Jan 2011 16:48:57 -0700
Subject: ioremap amba device registers 2.6.28-rc2
In-Reply-To: <AANLkTikjCM6vw0nFsjO9YqY_=ztzSTpodDhGfLcJG=A+@mail.gmail.com>
References: <AANLkTikjCM6vw0nFsjO9YqY_=ztzSTpodDhGfLcJG=A+@mail.gmail.com>
Message-ID: <AANLkTi=79htFAxfnuxed1OSLag5e5+n7L5xQrVwBFOu+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arg, I meant kernel 2.6.38-rc2, so sorry.

On Sun, Jan 30, 2011 at 4:32 PM, Chris <therealbadguy@gmail.com> wrote:
> Trying to ioremap memory from 0xC0000000
>
> I expect it to map me to the registers for the MBX device on the iMX31
> Litekit from LogicPD
> on 2.6.19.2 with some out of tree freescale patches it works.
>
> Could there be other code to initialize this device somewhere in this kernel?
> or am I facing some type of memory mapping problem?
>
> I have been trying to learn about this from the ground up, but I am
> lost in a sea of information.
>
> is this the right place to request this type of information?
>
> Somewhat of a double post, but I think the previous question will be
> ignored for various reasons.
>
> Thanks
>
