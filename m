From: greg@kroah.com (Greg KH)
Date: Mon, 26 Oct 2009 16:42:47 -0700
Subject: dream in staging: remove wakelock support
In-Reply-To: <20091022090354.GA30695@elf.ucw.cz>
References: <20091022090354.GA30695@elf.ucw.cz>
Message-ID: <20091026234247.GA26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 11:03:54AM +0200, Pavel Machek wrote:
> 
> Includes changed so that <linux/sched.h> is now needed for
> TASK_INTERRUPTIBLE and friends, so include it.
> 
> Remove hooks for features not in mainline, such as earlysuspend and
> wakelocks.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Even after this patch, the code does not build at all.

I'm going to mark CONFIG_DREAM as BROKEN for now until the build errors
get resolved, is that fair?

thanks,

greg k-h
