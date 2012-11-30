From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Nov 2012 20:00:10 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix build of I2S driver
In-Reply-To: <20121127064313.GV9411@opensource.wolfsonmicro.com>
References: <1353944420-3972-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <15c501cdcc36$db54cb00$91fe6100$%kim@samsung.com>
 <20121127064313.GV9411@opensource.wolfsonmicro.com>
Message-ID: <1d7501cdcee9$ddefbb30$99cf3190$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, Nov 27, 2012 at 09:33:43AM +0900, Kukjin Kim wrote:
> 
> > I checked Samsung audio driver stuff just now. If you don't mind, I will
> > drop the patch 48a2050d ("ARM: SAMSUNG: Delete the unnecessary
variable")
> > instead of applying this.
> 
> That works just as well for me, thanks.  Padma, as I said in the commit
> log this should be done as part of a single patch series rather than
> sending separately to ARM or ASoC so that both trees continue to build
> at each point.
> 
> > If any unprepared patches for Samsung audio in my tree, please let me
> know.
> 
> Will do.

Mark, I'm holding on Padma's changes for Samsung audio.

If any updates about this from your side?

Is it ok to send current next/audio-samsung in my tree to upstream for v3.8?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
