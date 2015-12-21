From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Mon, 21 Dec 2015 15:54:08 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: enable TPS65217 regulator
In-Reply-To: <20151220184453.GB32594@localhost>
References: <1447225753-2788-1-git-send-email-afzal.mohd.ma@gmail.com>
 <20151220184453.GB32594@localhost>
Message-ID: <20151221102408.GA4339@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sun, Dec 20, 2015 at 10:44:53AM -0800, Olof Johansson wrote:
> On Wed, Nov 11, 2015 at 12:39:13PM +0530, Afzal Mohammed wrote:

> > Enable TPS65217 regulator to have rootfs in MMC for Beagle Bone's.
> > 
> > Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>

> Applied, thanks.

Would it be possible to consider the similar patch [1] from Nishant
Menon instead of this patch ?, though i am not satisfied with the
changelog in his, i.e. regarding mention that it is required only for
older Beagle Bones. He has sent the initial version of it (identical in
diff) before mine.

Sorry for the trouble and Thanks.

Regards
afzal

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393611.html
