From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 Jan 2016 08:37:24 +0000
Subject: [PATCH v7 04/10] mfd: axp20x: Add missing copyright notice
In-Reply-To: <CAGb2v674rg+-VwNPakqdYPvwH1p0tP+yAhr=Uas2RUr2rO+uEw@mail.gmail.com>
References: <1452655854-1528-1-git-send-email-wens@csie.org>
 <1452655854-1528-5-git-send-email-wens@csie.org>
 <20160125143957.GS3368@x1>
 <CAGb2v674rg+-VwNPakqdYPvwH1p0tP+yAhr=Uas2RUr2rO+uEw@mail.gmail.com>
Message-ID: <20160126083724.GY3368@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jan 2016, Chen-Yu Tsai wrote:

> On Mon, Jan 25, 2016 at 10:39 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 13 Jan 2016, Chen-Yu Tsai wrote:
> >
> >> When the driver was merged, the original author did not include a proper
> >> copyright notice. This patch adds the notice, backdated to when the
> >> driver was merged.
> >
> > This is very wordy.
> >
> > "Supply a backdated copyright notice."
> 
> Fine with me. Would you like me to send another version?

No, I will fix this for you.

> >> Cc: Carlo Caione <carlo@caione.org>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>
> >> New patch in v7.
> >>
> >> ---
> >>  drivers/mfd/axp20x.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Patch looks fine though:
> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> >> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >> index 3e186f2dcac3..cec51e689d1d 100644
> >> --- a/drivers/mfd/axp20x.c
> >> +++ b/drivers/mfd/axp20x.c
> >> @@ -5,6 +5,8 @@
> >>   * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
> >>   * as well as configurable GPIOs.
> >>   *
> >> + * Copyright (C) 2014 Carlo Caione
> >> + *
> >>   * Author: Carlo Caione <carlo@caione.org>
> >>   *
> >>   * This program is free software; you can redistribute it and/or modify
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
