From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 2 Jul 2010 16:08:56 +0900
Subject: [PATCH 29/33] Removing dead SND_SOC_SMDK2443_WM9710
In-Reply-To: <20100701130724.GC17698@sirena.org.uk>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<e5391de6858597bbfd43874aed124a73f74850b5.1277911346.git.siccegge@cs.fau.de>
	<AANLkTinZa7_TEjYFTu9V6obndpVvMmHppaOArM1AJg_t@mail.gmail.com>
	<20100701130724.GC17698@sirena.org.uk>
Message-ID: <AANLkTim0usB99K6orH0lxP73e-XK69ytdECtR5D1dPJt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 10:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jul 01, 2010 at 09:55:47PM +0900, Jassi Brar wrote:
>> On Thu, Jul 1, 2010 at 1:03 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
>> > SND_SOC_SMDK2443_WM9710 doesn't exist in Kconfig, therefore removing
>> > all references for it from the source code.
>
>> I'd rather have the code compiled unconditionally.
>
> Hrm, if this is part of the default hardware build we should get the
> driver merged.
But the machine driver is already there
   sound/soc/s3c24xx/smdk2443_wm9710.c
