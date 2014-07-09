From: greg@kroah.com (Greg KH)
Date: Wed, 9 Jul 2014 10:19:30 -0700
Subject: [PATCH] Removes FIXME message in usb.c
In-Reply-To: <1404924948-3298-1-git-send-email-xerofoify@gmail.com>
References: <1404924948-3298-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20140709171930.GA11527@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, this has been fun to watch on lkml for a while now, but really,
please, just stop doing this.  Randomly searching the kernel source for
FIXME lines and just commenting them out, isn't ok.  Almost always,
those lines are there because the original developer really doesn't know
how else to resolve the issue.

So, if the domain-specific-author doesn't have an idea of what to do,
how does someone who is brand-new to the code know better?

If you are looking for a task to do in the kernel, try
drivers/staging/*/TODO for a list.  Or look at the kernel janitor's list
on kernelnewbies.org.  Or try running the kernel and finding something
that is broken for you and fixing that.  Any of those would be better
than randomly deleting FIXME lines.  By doing that, you are just wasting
maintainer's time.  Which is the resource we have the least of at the
moment.

thanks,

greg k-h
