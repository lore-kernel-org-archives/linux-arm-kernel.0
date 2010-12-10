From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 10 Dec 2010 03:24:23 +0100 (CET)
Subject: [PATCH v2 4/6] msm: timer: SMP timer support for msm
In-Reply-To: <4D018B78.4010901@codeaurora.org>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
	<1291782501-3909-5-git-send-email-johlstei@codeaurora.org>
	<4D018B78.4010901@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1012100323400.2653@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Jeff Ohlstein wrote:
> >  struct sys_timer msm_timer = {
> >  	.init = msm_timer_init
> >  };
> >   
> Thomas, do you have any additional thoughts on this? Did I answer your
> questions
> sufficiently in the other thread?

I think so. I did not realize the PPI issue in the first place.

Thanks,

	tglx
