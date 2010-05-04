From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 01:24:20 +0100
Subject: S3C6410 power management support status
In-Reply-To: <20100429124509.GA11290@jeknote.loshitsa1.net>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
Message-ID: <20100504002420.GQ6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 03:45:09PM +0300, Yauhen Kharuzhy wrote:
> Hi.
> 
> Can anybody explain current status of S3C6410 power management support
> in mainline? Suspend-to-RAM looks completely broken in the current
> Linus's git tree.

I'd prefer if you didn't make sweeping accusations about the state of
a given piece of the kernel without having a good look first. From reading
your second post, it seems that what is actually the problem is that the
64XX support only currently handles wakeup configurations from the EINT
pins.


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
