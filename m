From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 3 Nov 2009 16:17:33 -0800
Subject: drivers/video/msm: update to new kernel
In-Reply-To: <20091022085639.GA30548@elf.ucw.cz>
References: <20091022085639.GA30548@elf.ucw.cz>
Message-ID: <20091103161733.970b885f.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2009 10:56:39 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> TASK_INTERRUPTIBLE and friends are now only available after including
> <linux/sched.h>, so include it when needed.
> 
> bus_id is no longer available/neccessary, so remove that.
> 
> Android pmem driver is not available in mainline, so remove its hooks
> from drivers/video.
> 

What is the impact of these changes?

#2 looks like it's a build fix.  #3 looks like it isn't a build fix. 
#1 is a mystery.
