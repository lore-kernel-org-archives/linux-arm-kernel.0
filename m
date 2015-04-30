From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 30 Apr 2015 17:40:35 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <554251B4.2030808@arm.com>
References: <1430402268.2868.20.camel@linaro.org> <554251B4.2030808@arm.com>
Message-ID: <1430412035.2868.40.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-30 at 17:00 +0100, Sudeep Holla wrote:
> 
> On 30/04/15 14:57, Jon Medhurst (Tixy) wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> >
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >
> > These have been kicking around out of tree for ages, any reason they
> > shouldn't be in mainline?
> 
> One possible reason could be that these values are not tuned(e.g.
> latency values, can they be same for both clusters ?)

I thought that both clusters being the same was questionable.

>  Though these
> reasons are not blocking and this patch will not cause any
> functionality break even if is merged as is.

My main purpose with trying to get this merged is so that people using
Juno for general testing and validation will actually have cpuidle
running and so potentially find more bugs.

If we wait until ARM have finished tweaking their firmware and tuning
benchmark runs to get 'optimum' values for their main usecases then I
suspect we'll be waiting a long time ;-)

-- 
Tixy
