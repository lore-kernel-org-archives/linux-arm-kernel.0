From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 16 May 2017 13:33:18 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170516111629.GC22219@n2100.armlinux.org.uk>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
 <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
 <20170516111629.GC22219@n2100.armlinux.org.uk>
Message-ID: <CAPv3WKdVTxN+Au85RAVyQ811ta3+aVXy-Bssv0dobEDwEK7e8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-16 13:16 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Tue, May 16, 2017 at 11:27:19AM +0200, Marcin Wojtas wrote:
>> I do not intend to interfere your work at all. I took a look on your
>> branch, and my patch does not seem to be really colliding with it. The
>> board is starting to get really popular and a lot has been happening
>> around it recently - missing bits like 'chosen' node or the interfaces
>> is pretty annoying.
>
> Can you describe what the problem is with the missing "chosen" node?
>
> It seems that command line arguments get passed into the kernel here
> just fine without it:
>
> Kernel command line: console=ttyS0,115200 panic=5 rootdelay=4 root=/dev/sda3 libata.force=3.0G
>
> for a kernel built with:
>
> CONFIG_CMDLINE=""
>

It will be very useful e.g. for UEFI boot.

Marcin
