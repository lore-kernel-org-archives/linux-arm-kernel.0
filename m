From: dave@stgolabs.net (Davidlohr Bueso)
Date: Tue, 3 Jan 2017 10:06:58 -0800
Subject: [RFC PATCH] sched: Remove set_task_state()
In-Reply-To: <20170103100453.GB5605@leverpostej>
References: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
 <20170103100453.GB5605@leverpostej>
Message-ID: <20170103180658.GA7003@linux-80c1.suse>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Jan 2017, Mark Rutland wrote:

>Does the below help?

It does, yes. Performance is pretty much the same with either function
without sysreg. With arm no longer in the picture, I'll send up another
patchset with this change as well as Peter's cleanup remarks.

Thanks,
Davidlohr
