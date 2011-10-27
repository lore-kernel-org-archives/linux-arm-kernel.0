From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 27 Oct 2011 18:57:20 +0530
Subject: [PATCH v3 1/4] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111027114935.GA7384@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-2-git-send-email-rnayak@ti.com>
	<20111027080953.GB18360@opensource.wolfsonmicro.com>
	<CACYZBRG+_mm1O7Qg+ENCcLBX72iEWWyJohD_9EpAaT+Pb54cEA@mail.gmail.com>
	<20111027114935.GA7384@opensource.wolfsonmicro.com>
Message-ID: <4EA95C38.2020804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2011 05:19 PM, Mark Brown wrote:
> On Thu, Oct 27, 2011 at 04:13:08PM +0530, Nayak, Rajendra wrote:
>
>> okay, here's an updated patch which does that. I also added a binding to
>> specify a descriptive name to the regulator outputs as you suggested in
>> the other thread.
>
> Looks good!  I guess we may run into issues with the status change thing
> but I think we need to gather some experience to figure that out and
> since it's implicit hopefully that won't have any compatibility issues
> if it does happen.
>
> Acked-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
>
> I guess it might be useful to resend without this bit at the top to make
> it easier for Liam to apply.

Thanks Mark, just resent the patch with your Ack included.
