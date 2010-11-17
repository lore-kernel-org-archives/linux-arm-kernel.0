From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 17 Nov 2010 15:35:26 +0200
Subject: [PATCH 2/2] ARM: kexec: Fix crash_setup_regs() for ARMv7 and
	CONFIG_THUMB2_KERNEL
In-Reply-To: <AANLkTi=4MLpX7+DoXs4a8Bcx2QrFH5ZVjL8qA5G_smaA@mail.gmail.com>
References: <1289913141-8559-1-git-send-email-dave.martin@linaro.org>
	<1289913141-8559-2-git-send-email-dave.martin@linaro.org>
	<20101117131146.GD19331@gw.healthdatacare.com>
	<AANLkTi=4MLpX7+DoXs4a8Bcx2QrFH5ZVjL8qA5G_smaA@mail.gmail.com>
Message-ID: <20101117133526.GE19331@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 01:26:02PM +0000, Catalin Marinas wrote:
> On 17 November 2010 13:11, Mika Westerberg <mika.westerberg@iki.fi> wrote:
[...]
> >
> > Quickly tested this and seems to work. So FWIW:
> >
> > Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
> 
> It's more like Tested-by :)  (unless you reviewed it as well, though
> there seems to be some confusion between Reviewed-by and Acked-by).

Well, I was the original author if this code so I thought that
Acked-by was right but Tested-by is fine :)

Regards,
MW
