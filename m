From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Dec 2011 10:51:36 +0900
Subject: [PATCH] ARM: S3C64XX: Reduce residency requirement for cpuidle WFI
 mode
In-Reply-To: <20111229103157.GA2909@opensource.wolfsonmicro.com>
References: <1324897126-8889-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <028a01ccc5da$6bdeaec0$439c0c40$%kim@samsung.com>
 <20111229103157.GA2909@opensource.wolfsonmicro.com>
Message-ID: <02c801ccc695$906d4a10$b147de30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Thu, Dec 29, 2011 at 12:31:58PM +0900, Kukjin Kim wrote:
> > Mark Brown wrote:
> 
> > > Entering and leaving WFI is really cheap so there's no reason to have
> much
> > > of a residency requirement for the state. Lower it to 1ms.
> 
> > > -		.target_residency	= 100000,
> > > +		.target_residency	= 1,
> 
> > OK, will apply.
> > Mark, do you want to send this before v3.2?
> 
> It doesn't seem super urgent, though it'd be nice to get it into 3.3
> with the original patch adding the support.

Ah, OK, I've applied this with that.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
