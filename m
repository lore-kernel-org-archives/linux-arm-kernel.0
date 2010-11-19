From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Nov 2010 09:55:23 +0900
Subject: [PATCH 1/9] S5PV310: DMA: Add platform devices for PL330 DMACs
In-Reply-To: <20101118112722.GA22410@sirena.org.uk>
References: <1288057238-25377-1-git-send-email-jassisinghbrar@gmail.com>
	<023c01cb74c6$ee6404f0$cb2c0ed0$%kim@samsung.com>
	<AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
	<20101118112722.GA22410@sirena.org.uk>
Message-ID: <006a01cb8784$7494e920$5dbebb60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Thu, Nov 18, 2010 at 06:24:40PM +0900, Jassi Brar wrote:
> 
> > I am re-submitting this 9 patch series after required updates.
> 
> All
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> It'd be good if we could get them into ASoC in some way this release
> (either by cross merging a branch or just applying them there) so we
> could get the rest of Jassi's Samsung cleanup patches in too.

Hi :-)

Yeah, I agree with you...I applied them into next-samsung-asoc and
for-broonie.

So you can get/merge them from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-asoc

As a note, following is merge commit of it in my for-next.
commit 5cb0bfd842fd2d5095a09de9548aeee287addcd0(Merge branch
'next-samsung-asoc' into for-next)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
