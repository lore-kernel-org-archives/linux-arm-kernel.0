From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 15:52:29 +0200
Subject: [PATCH 03/18] ARM: mvebu: enable E1000E in mvebu_v7_defconfig
In-Reply-To: <20160721144647.78fce4a8@free-electrons.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-4-git-send-email-jaz@semihalf.com>
 <20160721124408.GO1041@n2100.armlinux.org.uk>
 <20160721144647.78fce4a8@free-electrons.com>
Message-ID: <CAH76GKM1Ls0aHaT7SZch6y7xz+ywY_9RyzR55PnXXEsdGvnUxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel, Thmoas

2016-07-21 14:46 GMT+02:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Hello,
>
> On Thu, 21 Jul 2016 13:44:09 +0100, Russell King - ARM Linux wrote:
>> On Thu, Jul 21, 2016 at 02:43:59PM +0200, Grzegorz Jaszczyk wrote:
>> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>>
>> Why?  It's not like this is an on-soc device, but most likely a PCIe card.
>> Should we build-in all PCIe drivers?
>
> I agree.
>
>> I think it makes more sense to have this as a module rather than built-in.
>
> I would prefer to not have it all in the defconfig. I'd hate to have
> a defconfig that builds tons of random modules "just because".

Both Semihalf and Marvel ISL teams use E1000E NICs with Marvell boards
for development/testing purpose, so we always have to enable it
manually - that's the reason why I wanted to have it enabled by
default.
Nevertheless it is indeed not part of the SoC and I understand your
arguments. I will drop it in the next patch-set version

Thank you,
Grzegorz
