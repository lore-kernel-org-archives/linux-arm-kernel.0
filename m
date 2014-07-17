From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 17 Jul 2014 16:05:30 +0200
Subject: [PATCH 0/4 v2] hwmon: ntc_thermistor: prepose vendor prefix change
In-Reply-To: <CAHfPSqCGf2d6xXDGr974+4ipNsYx3-fOLT+u2OGN=c9FVPEkZg@mail.gmail.com>
References: <1403677773-21141-1-git-send-email-ch.naveen@samsung.com>
 <02b501cf9064$34f16b80$9ed44280$@samsung.com>
 <53AAD8C8.3080506@roeck-us.net>
 <CAHfPSqCGf2d6xXDGr974+4ipNsYx3-fOLT+u2OGN=c9FVPEkZg@mail.gmail.com>
Message-ID: <CABxcv=mko=1bQ+VnKhPtRbx6Leop+gRNNkiSO-CbvN=JiyWh2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Naveen,

On Thu, Jul 17, 2014 at 6:21 AM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
>
> Can you pull the 3/4 and 4/4 patches.
>

Patch 4/4 depends on the max77802 support series [0] since the ADC
uses the max77802 ldo9 regulator as its voltage supply. So that patch
can't be merged before the series land in mainline.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/7/14/273
