From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 19 May 2011 11:01:03 +0800
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <alpine.LFD.2.00.1105182234130.14430@xanadu.home>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTim_0eRvDkQwAYjTNQsOVQiHV+DdBQ@mail.gmail.com>
	<alpine.LFD.2.00.1105182234130.14430@xanadu.home>
Message-ID: <BANLkTinXQvrG3LeSEO9Lnam3Bvq3dDKOsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,
Thanks for your reply.

2011/5/19 Nicolas Pitre <nico@fluxnic.net>:
> On Thu, 19 May 2011, Barry Song wrote:
>
>> does it mean if we want to add a new SoC plat/mach, we will send
>> patches againest this tree?
>
> Yes. ?Or against latest mainline tree from Linus.
>
>> will this tree merge into rmk's tree? then rmk's tree will only manage
>> arm common codes?
>
> Something like that. ?The exact details will be fleshed out as we go.
> The idea is to give a round of review from a higher point of view to
> make sure no opportunities for code reuse is missed, etc. ?The mechanics
> of how this code transitions from this tree into mainline during the
> merge window is secondary.

i asked this because we wanted to send the source codes of
CSR(http://www.csr.com) to upstream as i have told you in LDS. it
looks like we need to follow the below new changes to make our source
codes acceptable?
1. arm device tree
2. new pinmux framework from Linus Walleij
3. move GPIO from plat/mach to drivers/gpio?

>
>
> Nicolas
-barry
