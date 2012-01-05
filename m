From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 05 Jan 2012 11:32:18 +0900
Subject: [PATCH 2/4] rtc-s3c: make room for more variants in devicetree
 block
In-Reply-To: <201201041512.55126.heiko@sntech.de>
References: <201112211014.30695.heiko@sntech.de> <4F042D61.2070309@samsung.com>
 <201201041251.42509.heiko@sntech.de> <201201041512.55126.heiko@sntech.de>
Message-ID: <00f601cccb52$3ee9d390$bcbd7ab0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:

> 
> Hi Kgene,
> 
> Am Mittwoch, 4. Januar 2012, 12:51:41 schrieb Heiko St?bner:
> > Hi Sylwester,
> >
> > Am Mittwoch, 4. Januar 2012, 11:43:45 schrieb Sylwester Nawrocki:
> > > Hello,
> > >
> > > On 12/21/2011 10:16 AM, Heiko St?bner wrote:
> > > > Use the data field of of_device_id to hold the type for
> > > > s3c_cpu_type.
> > > >
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> > > > ---
> > >
> > > This patch makes compilation with CONFIG_OF enabled fail with errors
> > > and warnings:
> > >
> > > drivers/rtc/rtc-s3c.c: In function ?s3c_rtc_get_driver_data?:
> > > drivers/rtc/rtc-s3c.c:454: warning: return makes integer from pointer
> > > without a cast
> > > drivers/rtc/rtc-s3c.c: At top level:
> > > drivers/rtc/rtc-s3c.c:674: error: request for member ?data? in
> something
> > > not a structure or union
> > > drivers/rtc/rtc-s3c.c:677: error: request for member ?data? in
> something
> > > not a structure or union
> > > drivers/rtc/rtc-s3c.c:680: error: request for member ?data? in
> something
> > > not a structure or union
> > > drivers/rtc/rtc-s3c.c:683: error: request for member ?data? in
> something
> > > not a structure or union
> > > make[2]: *** [drivers/rtc/rtc-s3c.o] Error 1
> >
> > thanks for spotting this.
> >
> > @kgene: Should this go on top of the rtc series, or should I prepare a
> v4
> > with these fixes included?
> never mind, I did both.
> 
> In reply to this mail you will find:
> - a single patch on top of the 4 original patches, fixing the problems
> sylwester reported
> - a v4 of the original series including the fixes to the problems, based
> on
> the code that you have in your rtc-branch
> 
> Please pick the apropriate variant to fix the problem :-)
> 
OK, since it has been merged into arm-soc, I will send a single patch to
arm-soc.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
