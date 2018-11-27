From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 27 Nov 2018 15:48:52 +0000
Subject: [PATCH] arm: always update thread_info->syscall
In-Reply-To: <20181127153553.GE30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
 <20181127105620.GD30658@n2100.armlinux.org.uk>
 <20181127153553.GE30658@n2100.armlinux.org.uk>
Message-ID: <23ea6d5cbaac4cc3ad60d6184bbd1997@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux
> Sent: 27 November 2018 15:36
...
> There appears to be no documentation at all of this interface, so there
> is no definition of how it is supposed to work or what it is supposed
> to expose beyond what little information is in the original patch:
> 
>   http://lkml.iu.edu/hypermail/linux/kernel/0807.2/0577.html
> 
>    This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
>    These use task_current_syscall() to show the task's current system call
>    number and argument registers, stack pointer and PC. For a task blocked
>    but not in a syscall, the file shows "-1" in place of the syscall number,
>    followed by only the SP and PC. For a task that's not blocked, it shows
>    "running".

I 'like' the way the columns for sp and pc jump about ...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
