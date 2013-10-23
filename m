From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 19:30:33 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022092410.GB15640@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com>
 <20131021170711.GA5256@netboy>
 <20131022092410.GB15640@ulmo.nvidia.com>
Message-ID: <20131023173032.GB5208@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:24:11AM +0200, Thierry Reding wrote:
> 
> Oh, I've been doing that for quite a while. In fact the patches that
> gave rise to the current frustration have been in a separate tree in
> various forms for over a year. But that's not what we want, is it?

I can't see anything wrong with that. Your code is not the first to
have to wait for a long time before being finally merged. Think of
alsa, or of the pps stuff, or wakelocks, or preempt_rt, etc, etc.

As an end user, I don't mind waiting for a feature if that means
stability and QA. If I get impatient, still I always have the choice
to take a development version. But I do not want to be forced to take
unfinished work in a released kernel.

> I
> used to think that we actively wanted people to contribute code back
> upstream, so telling everyone to keep code in their own trees isn't
> helping anyone.

Actually, I mean to propose that the ARM/DT people use a single
marshaling tree, one step away in the process from mainline.

Thanks,
Richard
