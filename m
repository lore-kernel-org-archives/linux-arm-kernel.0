From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 24 Nov 2014 09:57:46 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
In-Reply-To: <20141121131036.GA18931@localhost.localdomain>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com> <20141120144028.GB5809@localhost.localdomain>
 <546F2BA4.4000808@ti.com> <20141121131036.GA18931@localhost.localdomain>
Message-ID: <5472F30A.1000608@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 02:10 PM, Richard Cochran wrote:

> On the BB white using the LCD4 cape and the shipped debian kernel, the
> cursor *does* jump away, but not as often or as far as on the custom
> design I was working with.

This sounds like the ADC is still sampling while the input data becomes
invalid. Usually there is a resistor on the wiper line and the
touchscreen manual says how much it should be at least. Could you
please check if this is properly installed?

> 
> Thanks,
> Richard

Sebastian
