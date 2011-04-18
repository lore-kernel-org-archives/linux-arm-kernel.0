From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Apr 2011 18:56:46 +0100
Subject: [PATCH 4/6] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <4DA8F634.9080803@codeaurora.org>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-5-git-send-email-will.deacon@arm.com>
	<4DA8F634.9080803@codeaurora.org>
Message-ID: <1303149406.13157.16.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhijeet,

On Sat, 2011-04-16 at 02:51 +0100, Abhijeet Dharmapurikar wrote:
> Will Deacon wrote:
> > This patch updates the MSM gpio chained IRQ handler to use the chained
> > IRQ enter/exit functions in order to function correctly on primary
> > controllers with different methods of flow control.
> >
> > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-msm/gpio-v2.c |   10 ++++++++--
> >  1 files changed, 8 insertions(+), 2 deletions(-)

[...]

> Reviewed-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Tested-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Thanks for getting round to looking at this. I don't have any Qualcomm
hardware myself (feel free to send me some :) so I'm uneasy without the
Tested-by tags.

I'll add your tags for this patch and the final one in the series.

Cheers,

Will
