From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 14:04:57 +0100
Subject: [PATCH] kirkwood: fix spelling mistake
In-Reply-To: <trinity-8590509b-8acc-44c0-86dc-8cf16ea8ad8a-1479448964051@3capp-gmx-bs34>
 (p. wassi's message of "Fri, 18 Nov 2016 07:02:44 +0100")
References: <trinity-6911950b-e19a-4b44-aeed-adaccbc33164-1479414587776@3capp-gmx-bs50>
 <20161117210227.GL5574@lunn.ch>
 <trinity-8590509b-8acc-44c0-86dc-8cf16ea8ad8a-1479448964051@3capp-gmx-bs34>
Message-ID: <87lgwh9bwm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
 
 On ven., nov. 18 2016, p.wassi at gmx.at wrote:

> Hi Andrew,
>
>> You should also send the patch to the Marvell MVEBU
>> maintainers.
>
> how do I find Marvell mvebu maintainers?
> The list in
> https://www.kernel.org/doc/linux/MAINTAINERS
> (line 1429) references mvebu/kirkwood and gave me the
> mailing list's address. Should the other two maintainers
> be addressed directly?

About putting the maintainer in Cc. Using ./scripts/get_maintainer.pl
coudl help you to find the people to put in CC. For example for your
patch:
Jason Cooper <jason@lakedaemon.net> (maintainer:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...)
Andrew Lunn <andrew@lunn.ch> (maintainer:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...)
Gregory Clement <gregory.clement@free-electrons.com> (maintainer:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...)
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> (maintainer:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...)

So indeed you should put the 4 co-maintainers in Cc.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
