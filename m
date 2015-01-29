From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 29 Jan 2015 16:26:39 +0200
Subject: [PATCH 6/9] clocksource: Driver for Conexant Digicolor SoC timer
In-Reply-To: <1422538656.32520.4.camel@x220>
References: <54CA3044.6070501@linaro.org>
 <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
 <1422536899-16609-6-git-send-email-daniel.lezcano@linaro.org>
 <1422538656.32520.4.camel@x220>
Message-ID: <20150129142639.GI19448@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Jan 29, 2015 at 02:37:36PM +0100, Paul Bolle wrote:
> On Thu, 2015-01-29 at 14:08 +0100, Daniel Lezcano wrote:
> > From: Baruch Siach <baruch@tkos.co.il>
> > +config DIGICOLOR_TIMER
> > +	bool
> 
> And the select for this symbol (see https://lkml.org/lkml/2015/1/26/360)
> will be provided in a separate patch? Because this patch, by itself,
> won't allow DIGICOLOR_TIMER to be set, will it?

Yes. Posted yesterday. See 
http://article.gmane.org/gmane.linux.ports.arm.kernel/390166.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
