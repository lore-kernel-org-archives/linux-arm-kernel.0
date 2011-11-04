From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Fri, 4 Nov 2011 10:57:23 +0000
Subject: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <CAOMZO5BRzQgbi5K2n8bwzyxJpoh_T476iOkwu8uCk_A0nD9eeg@mail.gmail.com>
References: <1320383924-18762-1-git-send-email-b39297@freescale.com>
	<3D55990BDF4852409EA769663F22E54AC04776@039-SN1MPN1-006.039d.mgd.msft.net>
	<CAOMZO5BRzQgbi5K2n8bwzyxJpoh_T476iOkwu8uCk_A0nD9eeg@mail.gmail.com>
Message-ID: <3D55990BDF4852409EA769663F22E54AC049C7@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio:

  Thank you for the comments!

Best Regards
Wu Guoxing

-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: Friday, November 04, 2011 4:11 PM
To: Wu Guoxing-B39297
Cc: linux-arm-kernel at lists.infradead.org; s.hauer at pengutronix.de; shawn.guo at linaro.org
Subject: Re: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

On Fri, Nov 4, 2011 at 4:01 AM, Wu Guoxing-B39297 <B39297@freescale.com> wrote:
> Changes since v1:
> ?Introduce "struct mc9s08dz60" for i2c client, instead of a static variable.

Patch history should be below the --- line.

> -----Original Message-----
> From: Wu Guoxing-B39297
> Sent: Friday, November 04, 2011 1:19 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: s.hauer at pengutronix.de; shawn.guo at linaro.org; Wu Guoxing-B39297
> Subject: [PATCH v2] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
>
> we only use the gpio function of mc9s08dz60 mcu chip, so just add the gpio driver, as this mcu will never be used in other board.
>
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> ---
> ?drivers/gpio/Kconfig ? ? ? ? ? | ? ?6 ++
> ?drivers/gpio/Makefile ? ? ? ? ?| ? ?1 +
> ?drivers/gpio/gpio-mc9s08dz60.c | ?180 
> ++++++++++++++++++++++++++++++++++++++++
> ?3 files changed, 187 insertions(+), 0 deletions(-) ?create mode 
> 100644 drivers/gpio/gpio-mc9s08dz60.c

Run ./script/getmaintainer.pl on your patch to get the lists and people you should also Cc.
