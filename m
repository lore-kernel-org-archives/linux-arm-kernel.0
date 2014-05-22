From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 May 2014 10:04:47 +0100
Subject: CLONE from pthread_create fails with ERESTARTNOINTR and
 application crashes
In-Reply-To: <CAGJAg9EHSgOg3trryA5Zb5ms8pfTX6Y7DF4s-mEP6YZmD8twVw@mail.gmail.com>
References: <CAGJAg9EHSgOg3trryA5Zb5ms8pfTX6Y7DF4s-mEP6YZmD8twVw@mail.gmail.com>
Message-ID: <20140522090447.GA14641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 02:40:16PM +0100, Raghu Pv wrote:
> CLONE from pthread_create fails with ERESTARTNOINTR and application crashes

[...]

> Executing a multithreaded application that creates and terminates
> threads and also there a lot of signals

Do you have sample source for that?

> If a signal arrives during execution of clone(), clone is returning
> ERESTARTNOINTR to userspace.

With which kernel version? Your quote from fork.c doesn't match mainline.
Can you reproduce with -rc6?

Will
