From: consul.kautuk@gmail.com (kautuk.c @samsung.com)
Date: Sat, 19 Nov 2011 22:18:48 -0500
Subject: [PATCH 1/1 v4] arm: fault.c: Port OOM changes into do_page_fault
In-Reply-To: <1321181347-4391-1-git-send-email-consul.kautuk@gmail.com>
References: <1321181347-4391-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <CAFPAmTRK6OubP5u_YwcRyyN6vujgqwBaq8-JobdnnYmjEE3Y+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> Port these changes to ARM.

Did anyone get a chance to look at version 4 of this patch ?

I have incorporated changes as suggested by Russell during version 3 review.

Can I improve this patch in any way ?

>
> Without these changes, my ARM board encounters many hang and livelock
> scenarios.
> After applying this patch, OOM feature performance improves according to
> my testing.
>
