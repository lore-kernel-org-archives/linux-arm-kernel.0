From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 9 Jul 2014 14:23:33 +0100
Subject: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
In-Reply-To: <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
 <20140626113939.GP32514@n2100.arm.linux.org.uk>
 <53AC0BCC.1010608@samsung.com>
 <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
Message-ID: <20140709142333.503a9e39@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I like the sound of going to the standard ttyS notation and only
> providing ports for ones that exist, but is this userspace-visible

ttyS is 8250 compatible UARTS.

If the Samsung is not an 8250 compatible UART then it doesn't belong as
ttyS from the kernel perspective.

How your udev handles it is up to you.

Alan
