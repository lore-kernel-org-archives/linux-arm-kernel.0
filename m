From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 May 2011 16:19:06 +0900
Subject: [PATCH 2/7] ASoC: Remove to support sound for S5PC100
In-Reply-To: <BANLkTimZnzfWuKB+J0z7YT-0ZT_B5_OvBQ@mail.gmail.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
	<BANLkTinqyFCwp3FCOyW=gVhotd1p8DnDyw@mail.gmail.com>
	<03fa01cc1079$c2583670$4708a350$%kim@samsung.com>
	<BANLkTimZnzfWuKB+J0z7YT-0ZT_B5_OvBQ@mail.gmail.com>
Message-ID: <002201cc1399$8c39bd20$a4ad3760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> On Thu, May 12, 2011 at 1:23 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> >> You might also want to remove smdkc100 support from
> >>  sound/soc/samsung/smdk_wm9713.c
> >>  sound/soc/samsung/smdk_wm8580.c
> >> And three other references to smdkc100 in sound/soc/samsung/Kconfig
> >
> > I found something for smdkc100 in smdk_wm8580.c but I'm not sure which
> should be removed in smdk_wm9713.c.
> >
> 
> Just the comment about jumper settings on smdkc100
> otherwise it gives wrong impression that the board is supported.

Ok, I agree.

But I'm not sure what is required for it.
Could you please let me know about it after discussion of removing C100?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
