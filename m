From: michael@walle.cc (Michael Walle)
Date: Sun, 13 Nov 2011 00:40:42 +0100
Subject: [PATCH] ARM: Add lsxhl machine type to mach-types
In-Reply-To: <20111112230157.GB27746@n2100.arm.linux.org.uk>
References: <1320699251-26115-1-git-send-email-michael@walle.cc>
 <201111121702.15274.michael@walle.cc>
 <20111112230157.GB27746@n2100.arm.linux.org.uk>
Message-ID: <201111130040.42616.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 13 November 2011, 00:01:57 schrieb Russell King - ARM Linux:
> Please read the comments at the top of the file:
sorry, read that over.

> # This is a cut-down version of the file; it contains only machines that
> # are merged into mainline or have been edited in the machine database
> # within the last 12 months.  References to machine_is_NAME() do not count!
> 
> It gives you the criteria for entries being removed from the file.
> 
> What guarantee do we have that support for this platform will be found
> to be acceptable (in it's non-DT form) and will be accepted into mainline
> (which is the basic requirement for the entry staying in the kernel's
> version of this file.)
ok, if only non-dt machine entries will stay in this file, this request is 
already obsolete. my initial non-dt support patch was NAK'ed because the 
kirkwood arch doesn't accept old-fashioned board support patches anymore.

then, i guess, the problem is on the uboot side, at least if they want to 
support both device tree based and old-fashioned setup code (eg. backported 
device support.)

-- 
Michael
