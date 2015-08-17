From: drew.richardson@arm.com (Drew Richardson)
Date: Mon, 17 Aug 2015 13:58:09 -0700
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <20150804001522.GA13214@dreric01-gentoo.localdomain>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
Message-ID: <20150817205809.GA16506@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 01:15:23AM +0100, Drew Richardson wrote:
> Add additional information about hardware events to make counters self
> describing. This makes the hardware PMUs easier to use as perf list
> contains the possible events instead of users having to refer to
> documentation like the ARM TRMs. This could also allow tools like
> oprofile to support PMUs without requiring an update.
> 
> Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> ---
>  arch/arm/kernel/perf_event.c    |   1 +
>  arch/arm/kernel/perf_event_v7.c | 617 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 618 insertions(+)

Any concerns with merging this?

Thanks,

Drew
