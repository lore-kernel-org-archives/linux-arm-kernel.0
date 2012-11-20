From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 15:30:08 +0900
Subject: Forward: [PATCH 146/493] ASoC: remove use of __devexit_p
In-Reply-To: <s5hehjordzj.wl%tiwai@suse.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-146-git-send-email-wfp5p@virginia.edu>
 <s5hehjordzj.wl%tiwai@suse.de>
Message-ID: <20121120063006.GF10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 07:21:36AM +0100, Takashi Iwai wrote:
> Yet another one for ASoC.

> Date: Mon, 19 Nov 2012 13:21:35 -0500
> From: Bill Pemberton <wfp5p@virginia.edu>
> To: gregkh at linuxfoundation.org
> Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, M R
>  Swami Reddy <mr.swami.reddy@ti.com>, Vishwas A Deshpande
>  <vishwas.a.deshpande@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
>  Jarkko Nikula <jarkko.nikula@bitmer.com>, Eric Miao
>  <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian
>  Zhuang <haojian.zhuang@gmail.com>, Philipp Zabel
>  <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Ben
>  Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>,
>  alsa-devel at alsa-project.org, uclinux-dist-devel at blackfin.uclinux.org,
>  device-drivers-devel at blackfin.uclinux.org,
>  patches at opensource.wolfsonmicro.com, linuxppc-dev at lists.ozlabs.org,
>  linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org,
>  linux-samsung-soc at vger.kernel.org

This time you've got an extravagantly large CC list but not managed to
CC the maintainers at all...  ho hum.  Anyway, this doesn't apply
against current code due to the Atmel changes.  Please rebase against
for-next (or ideally the topic branches) and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/b062ae9d/attachment.sig>
