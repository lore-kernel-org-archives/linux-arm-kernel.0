From: george@znau.edu.ua (George Kashperko)
Date: Thu, 14 Apr 2011 00:24:10 +0300
Subject: [RFC][PATCH V4] axi: add AXI bus driver
In-Reply-To: <BANLkTinLn4Ug=gX4coHJbSzrkxdSMjgGeg@mail.gmail.com>
References: <1302634375-2378-1-git-send-email-zajec5@gmail.com>
	<20110413163113.GA24015@kroah.com>
	<BANLkTin-4HrJzNrLOxRy_-a98S3ZF4aSQw@mail.gmail.com>
	<1302726703.8015.1.camel@dev.znau.edu.ua>
	<BANLkTimwZOJ0a5kVfaUzEcsMc39H999u0A@mail.gmail.com>
	<1302727516.8015.9.camel@dev.znau.edu.ua>
	<BANLkTi=wzzzeF-PmqLt9o8arW7nRaFRRJw@mail.gmail.com>
	<1302729243.8479.1.camel@dev.znau.edu.ua>
	<BANLkTinLn4Ug=gX4coHJbSzrkxdSMjgGeg@mail.gmail.com>
Message-ID: <1302729850.8479.7.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 2011/4/13 George Kashperko <george@znau.edu.ua>:
> >> I had no idea what you were referring to. We do not dig into PCIe
> >> functions yet, so I believe for now we need this "if".
> > You are already deep inside. Your host code drives pci function.
> 
> But I don't use multiple PCIe functions, do not focus on that at all.
> 
Don't see anything in the host driver code preventing it to be bound to
functions other than 0. But anyways if you sure your host will be used
by several cores then why don't you spinlock window accesses ?

Have nice day,
George
