From: dzickus@redhat.com (Don Zickus)
Date: Mon, 6 Dec 2010 08:56:11 -0500
Subject: mpcore watchdogs questions
In-Reply-To: <AANLkTikRbF9yVUMLo2rRfM0zC2GRRhA7MD7dyCMR2+Sm@mail.gmail.com>
References: <4CF8F702.1070502@stericsson.com>
	<20101203145803.GQ18100@redhat.com>
	<AANLkTikRbF9yVUMLo2rRfM0zC2GRRhA7MD7dyCMR2+Sm@mail.gmail.com>
Message-ID: <20101206135611.GC21786@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 10:34:31AM +0100, Per Fransson wrote:
> 
> The way I see it, the idea behind the lockup detection code, and please correct
> me if I'm wrong, is to cover the following case on a per-CPU basis:
> 
> * Assuming the CPU in question is actually chugging along, is it
> getting real work
> done, where "real work" is defined as being able to schedule a high-prio kernel
> thread and have it perform the actions expected of it (kicking the watchdog).
> In the hardlockup case "real work" is instead defined as being able to
> respond to
> hrtimers going off.

Yup, that sounds right.

Cheers,
Don
