From: Andrew_Gabbasov@mentor.com (Gabbasov, Andrew)
Date: Thu, 6 Dec 2012 10:15:41 +0000
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
In-Reply-To: <20121206095739.GA749@mudshark.cambridge.arm.com>
References: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
 <20121203133735.GG20074@mudshark.cambridge.arm.com>
 <20121203141251.GB14363@n2100.arm.linux.org.uk>
 <6C5EA58090A5ED459815C4D04C2B466F8C567A21@EU-MBX-01.mgc.mentorg.com>
 <20121204103809.GD14363@n2100.arm.linux.org.uk>
 <20121204104038.GA23368@mudshark.cambridge.arm.com>
 <20121204115526.GK23368@mudshark.cambridge.arm.com>
 <6C5EA58090A5ED459815C4D04C2B466F8C567E42@EU-MBX-01.mgc.mentorg.com>,
 <20121206095739.GA749@mudshark.cambridge.arm.com>
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C567E6C@EU-MBX-01.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Dec 06, 2012 at 09:53:58AM +0000, Gabbasov, Andrew wrote:
> > Hi Will,
> 
> Hello Andrew,
> 
> > Thank you for the patch, I was thinking about something like this too, but was in a doubt
> > that reverse order could be for a purpose ;-)
> 
> Nope, it think it was an oversight when the entry path was cleaned up.
> 
> > Minor question: what is the version this patch is against? The latest version in Linus'es tree
> > does not have "current_thread_info()->syscall = scno;" at the beginning of
> > syscall_trace_exit. Or is it just a "proof of concept" patch and will be modified before
> > merging to the source?
> 
> It's based on what Russell has queued for 3.8 (there is some seccomp stuff
> in there). If you're happy with the patch, I can stick it in the patch
> system once I've given it some more testing.
> 
> Will

Yes, the patch looks good to me.

Thanks.
Andrew
