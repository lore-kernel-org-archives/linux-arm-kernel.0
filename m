From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 12 May 2011 14:08:55 +0530
Subject: [PATCH 2/7] ASoC: Remove to support sound for S5PC100
In-Reply-To: <03fa01cc1079$c2583670$4708a350$%kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
	<BANLkTinqyFCwp3FCOyW=gVhotd1p8DnDyw@mail.gmail.com>
	<03fa01cc1079$c2583670$4708a350$%kim@samsung.com>
Message-ID: <BANLkTimZnzfWuKB+J0z7YT-0ZT_B5_OvBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 1:23 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

>> You might also want to remove smdkc100 support from
>> ?sound/soc/samsung/smdk_wm9713.c
>> ?sound/soc/samsung/smdk_wm8580.c
>> And three other references to smdkc100 in sound/soc/samsung/Kconfig
>
> I found something for smdkc100 in smdk_wm8580.c but I'm not sure which should be removed in smdk_wm9713.c.
>

Just the comment about jumper settings on smdkc100
otherwise it gives wrong impression that the board is supported.
