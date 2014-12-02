From: geoff@infradead.org (Geoff Levand)
Date: Tue, 02 Dec 2014 12:26:04 -0800
Subject: [PATCH 0/8] arm64 kexec kernel patches V6
In-Reply-To: <20141128065636.GA3676@darkstar.nay.redhat.com>
References: <cover.1415926876.git.geoff@infradead.org>
 <20141127061947.GB2860@darkstar.nay.redhat.com>
 <20141128065636.GA3676@darkstar.nay.redhat.com>
Message-ID: <1417551964.7724.2.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Fri, 2014-11-28 at 14:56 +0800, Dave Young wrote:
> Tested your master branch, works for me with below setup:
> UEFI boot, CONFIG_KVM=n, maxcpus=1, --lite
> 
> But --dtb still does not work if there's no /proc/device-tree, failed as below:
> unrecoverable error: could not scan "/proc/device-tree/": No such file or directory.
> 
> kexec without --lite also does not work, looks like it hangs after "Bye" ..

I'll be away from the office this week.  I'll look into this when I
return.

-Geoff
