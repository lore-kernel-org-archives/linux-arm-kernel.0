From: rusko.peter@prolan.hu (Peter Rusko)
Date: Thu, 24 Nov 2011 16:45:52 +0100
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <20111124125952.GD18060@S2100-06.ap.freescale.net>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <20111124125952.GD18060@S2100-06.ap.freescale.net>
Message-ID: <4ECE66B0.5010802@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think this patch should probably be split into 4.
>
>   * lradc drivers/staging/iio/adc/ (rather than drivers/misc/) part
>   * lradc arch/arm/mach-mxs part
>   * touchscreen drivers/input/touchscreen part
>   * touchscreen arch/arm/mach-mxs part
>
> And you need to look into MAINTAINERS for the mailing list and people
> that the 'drivers' part should be sent to.
>

You're right, I'm working on it.

Shall I split the arch/arm/mach-mxs parts? In this patch I use 
HAVE_MXS_LRADC to compile both of them. I think they come together, the 
ADC supports the touchscreen, so there is no need to split them.

-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
