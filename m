From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 10 Dec 2010 15:28:42 +0100
Subject: Question about ARM virtualization
In-Reply-To: <182024c.be2d.12cc1439ae9.Coremail.bill_carson@126.com>
References: <182024c.be2d.12cc1439ae9.Coremail.bill_carson@126.com>
Message-ID: <AANLkTi=MpxC8wZmdEO6_MDH8UeXdzkh=Eugg9o2CXORA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yes, I am working on a KVM for ARM solution.

Current status is that it runs, although very slow on ARMv5, it fully
boots a kernel on ARMv6 on hardware, but has some issues in bringing
up user space, and finally we have an ARMv7 version which boots the
kernel with the same user space issues as on ARMv6 on simulators, but
sees a crash on real hardware when switching host vectors. You may
want to look at our sources http://git.ncl.cs.columbia.edu/git/ and
there's also a mailing list
https://lists.cs.columbia.edu/cucslists/listinfo/android-virt.

Best,
Christoffer

On Tue, Dec 7, 2010 at 3:37 PM, rocky <bill_carson@126.com> wrote:
> se is hardware virtualizable, while some people have already doing this on non-virtualizable ARM core;
>
> So is there any open-source project on virtualizable ARM or non-virtualizable ARM availiable for study?
