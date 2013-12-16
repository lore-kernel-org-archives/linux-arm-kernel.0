From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Mon, 16 Dec 2013 11:09:59 -0500
Subject: [PATCH v2] ARM: dts: vf610: make pinctrl nodes board specific
In-Reply-To: <20131214054455.GB6903@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Sat, 14 Dec 2013 13:44:57 +0800")
References: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
 <1386686213-13801-1-git-send-email-shawn.guo@linaro.org>
 <87mwk5eugj.fsf@nbsps.com> <87haadesl9.fsf@nbsps.com>
 <20131214054455.GB6903@S2101-09.ap.freescale.net>
Message-ID: <87ppowydyg.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Thu, Dec 12, 2013 at 03:12:50PM -0500, Bill Pringlemeir wrote:

>> The SAI might not use 'VF610_PAD_PTB18__EXT_AUDIO_MCLK' nor either
>> 'VF610_PAD_PTA16__SAI2_TX_BCLK' or 'VF610_PAD_PTA21__SAI2_RX_BCLK'.
>> There are some pins that are absolutely needed for a module to function
>> and then there are some optional pins.
>>
>> That said, this is nothing that you have changed.  It was like this to
>> begin with in the generic 'vf610.dtsi' file.

On 14 Dec 2013, shawn.guo at linaro.org wrote:

> Yea, the PINGRP defined in vf610-pingrp.h should be generic rather than
> board specific.  It seems that VF610_SAI2_PINGRP1 is used nowhere for
> now, so we can change it easily.  Patch is welcomed.

Alison Wang and Xiubo Li are working on this driver now,

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/068060.html

I would wait until after that is accepted.  I just wondered if my
understanding was correct.  Sorry, I missed all your IMX patches which
probably explained this.

Thanks,
Bill Pringlemeir.
