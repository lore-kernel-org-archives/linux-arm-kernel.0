From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 23 Oct 2014 22:11:34 +0200
Subject: [BISECTED] arm: mvebu: Kernel hang after ae9304c9d311 if
 OF_SELFTEST=y
In-Reply-To: <87h9yuu9jk.fsf@natisbad.org> (Arnaud Ebalard's message of "Thu,
 23 Oct 2014 16:48:15 +0200")
References: <87mw8nt5io.fsf@natisbad.org>
 <5448EB5E.3010405@free-electrons.com> <87h9yuu9jk.fsf@natisbad.org>
Message-ID: <87wq7q4kcp.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

arno at natisbad.org (Arnaud Ebalard) writes:

>>> I bisected it up to ae9304c9d31117 ("Adding selftest testdata
>>> dynamically into live tree"). For a while, my kernels are compiled w/
>>> OF_SELFTEST and it works w/o issue. After that commit, boot hangs as
>>
>> It would be interesting to have a feedback of a kernel with an appended dtb
>> and OF_SELFTEST enabled to a different platform (ie non mvebu). Then we
>> will know if it something related to mvebu or to the device tree support.
>>
>> I will try to see if I can do this.
>
> I can test that on a kirkwood (6282) this evening.

FWIW, the problem does not only show up on Armada 370 but also on
kirwood. I just tested it on a ReadyNAS Duo v2. I do not have any
other non-mvebu platform at hand ATM. I'll try and see if I can
find some ARM board to boot a recent kernel tomorrow.

Cheers,

a+
