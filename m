From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 14:35:28 +0900
Subject: [rtc-linux] [PATCH v3 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <AANLkTimoyYGXc-bwQCOWFSBP+nWTVVri6ZMsNuwwYtC7@mail.gmail.com>
References: <1280379570-6147-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTimoyYGXc-bwQCOWFSBP+nWTVVri6ZMsNuwwYtC7@mail.gmail.com>
Message-ID: <009b01cb2edf$dcefd140$96cf73c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:
> 
> 2010/7/29 Kukjin Kim <kgene.kim@samsung.com>:
> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
> >
> > RTC needs to be initialized when BCD registers have invalid value.
> >
> > Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > ---
> > Hi, Alessandro Zummo
> > Just moved the routine to support all Samsung SoCs' RTC.
> > Is still your ack valid?
> 
Hi Wan,

> Alessandro is busy, not every patch he can reviewed and acked,
> if nobody have any other suggestions about your patch, you can
> merge it. if you donot have specific git tree to merge it, you can get
> Andrew's help.
> 
Thanks for your rapid response. ;-)

(snip)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
