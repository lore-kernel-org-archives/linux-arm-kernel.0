From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 18:13:58 +0000
Subject: [RFC PATCH] sched: Remove set_task_state()
In-Reply-To: <20170103180658.GA7003@linux-80c1.suse>
References: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
 <20170103100453.GB5605@leverpostej>
 <20170103180658.GA7003@linux-80c1.suse>
Message-ID: <20170103181357.GA21915@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:06:58AM -0800, Davidlohr Bueso wrote:
> On Tue, 03 Jan 2017, Mark Rutland wrote:
> 
> >Does the below help?
> 
> It does, yes. Performance is pretty much the same with either function
> without sysreg.

Great!

> With arm no longer in the picture, I'll send up another patchset with
> this change as well as Peter's cleanup remarks.

I intend to send a cleaned up version of the arm64 patch to Catalin in a
moment; the read_sysreg() issue is a regression introduced in v4.10-rc1,
so we should be able to get it in as a fix.

Thanks,
Mark.
