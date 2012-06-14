From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jun 2012 14:47:15 +0100
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <20120612143545.GC7918@n2100.arm.linux.org.uk>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <4FD6B472.7040609@zytor.com> <20120612143545.GC7918@n2100.arm.linux.org.uk>
Message-ID: <20120614134715.GE28714@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 03:35:45PM +0100, Russell King - ARM Linux wrote:
> I'd like to toss this into my kautobuild+boot, but at the moment that's
> rather pointless because OMAP has been broken since towards the end of
> the merge window, and so far no sign of the fix hitting mainline any
> time soon...

Okay, given the issue raised with memcpy() calling __builtin_memcpy(),
I don't think there's any value to me actually testing this, because
that seems to need to be solved first?
