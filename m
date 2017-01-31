From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Jan 2017 12:14:30 +0000
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <20170130215430.GJ2206@mai>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
 <765699aa-cbc6-67eb-9108-cbf335338e4c@linaro.org>
 <35cf654f-3944-fc76-5120-25e33f71be4f@arm.com>
 <20170124163551.GB2021@mai> <20170130155209.GC1160@leverpostej>
 <20170130215430.GJ2206@mai>
Message-ID: <20170131121429.GC11191@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:54:30PM +0100, Daniel Lezcano wrote:
> On Mon, Jan 30, 2017 at 03:52:09PM +0000, Mark Rutland wrote:
> > Hi Daniel,
> > 
> > On Tue, Jan 24, 2017 at 05:35:51PM +0100, Daniel Lezcano wrote:
 
> It is up to me to ensure the clockevent/clocksource drivers in general are
> following the right direction. And this driver looks more and more opaque. I
> will spend some times to do a review of the driver as soon as I have time.

FWIW, I'd locally fixed up the patches in the branch I previously
mentioned, so many issues in this series no longer exist.

I will post the cleaned up series momentarily. Hopefully that should be
less painful to review.

Thanks,
Mark.
