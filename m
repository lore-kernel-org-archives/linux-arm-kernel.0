From: joe.dougherty@gecoinc.com (Joe Dougherty)
Date: Mon, 11 Jun 2018 10:21:59 -0700
Subject: A72 access to cache syndrome registers (arm64)
Message-ID: <CAPfxgkbKbEP-GgkX36cqLKxb0UW2GuGdpT4F9Fe4gkhn9d1zJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello -
Is there any current support for reading "CPU Memory Error Syndrome"
and L2 Memory Error Syndrome" registers from userspace? I am
monitoring for particular cache related events.  I'm trying to avoid
writing a kernel module but it looks like  that may be my only option
as I am not seeing support for access to these registers. Would a perf
driver be more appropriate? Any advice/input  appreciated.

My Linux kernel is 4.14 but I could adjust is support is available elsewhere.

Thanks,
Joe
