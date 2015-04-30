From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Apr 2015 17:00:52 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <1430402268.2868.20.camel@linaro.org>
References: <1430402268.2868.20.camel@linaro.org>
Message-ID: <554251B4.2030808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/04/15 14:57, Jon Medhurst (Tixy) wrote:
> From: Jon Medhurst <tixy@linaro.org>
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>
> These have been kicking around out of tree for ages, any reason they
> shouldn't be in mainline?

One possible reason could be that these values are not tuned(e.g.
latency values, can they be same for both clusters ?) Though these
reasons are not blocking and this patch will not cause any
functionality break even if is merged as is.

Regards,
Sudeep
