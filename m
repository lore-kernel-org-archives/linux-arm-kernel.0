From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 22 Dec 2011 07:04:28 +0900
Subject: [PATCHv2 resend] Fix compilation error when
 CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
In-Reply-To: <4EF23852.1050304@solonet.org.ua>
References: <4EE7BE5F.8020108@solonet.org.ua>
 <064501ccbfae$cf1e5cb0$6d5b1610$%kim@samsung.com>
 <4EF23852.1050304@solonet.org.ua>
Message-ID: <06fa01ccc02c$828b6810$87a23830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Denis Kuzmenko wrote:
> 
> On 12/21/2011 09:04 AM, Kukjin Kim wrote:
> > Denis Kuzmenko wrote:
> >>
> >> Fix compilation error when CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
> >>
> >> Signed-off-by: Denis Kuzmenko <linux@solonet.org.ua>
> >> ---
> >>
> >> Patch is against 3.2-rc4.
> >> CONFIG_S3C2410_IOTIMING is not selected for MACH_MINI2440. Because of
> this
> >> the
> >> file s3c2410-iotiming.c is not ever compiled and enabling
> >> CONFIG_CPU_FREQ_S3C24XX_DEBUGFS option caused undefined reference to
> >> function
> >> s3c2410_iotiming_debugfs defined in that file. s3c2410_iotiming_debugfs
> >> defined
> >> as NULL for this case.
> >>
> > Hi Denis,
> >
> > Well, there is no error when CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected in
> my
> > case and s3c2410-iotiming.c is built...when is it happened? I just
> selected
> > every regarding configuration in kernel menuconfig...
> 
> Please, try attached config (it's still failing in v3.2-rc6).
> 
Hi Denis,

Yes, when s3c2410 stuff is not selected, it happened.
Look at me soon and thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
