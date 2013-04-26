From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 26 Apr 2013 14:03:56 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
In-Reply-To: <51794C35.6070400@samsung.com>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
 <5178F8E0.6010606@linaro.org> <51794C35.6070400@samsung.com>
Message-ID: <2024174.Hoa4RbDIF3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 26, 2013 12:31:01 AM Kukjin Kim wrote:
> On 04/25/13 18:35, Daniel Lezcano wrote:
> > On 04/23/2013 04:41 PM, Daniel Lezcano wrote:
> >> Remove the duplicated code and use the cpuidle common code for initialization.
> >>
> >> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> >> ---
> >
> > Hi Kim and Ben,
> >
> > It is the last patch in the series which was not acked-by.
> > Rafael is willing to take it in its tree if you ack it.
> >
> > Are you ok if this patch ?
> >
> Looks OK to me, please go ahead with my ack if you want:
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
