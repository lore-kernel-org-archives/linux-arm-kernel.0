From: holler@ahsoftware.de (Alexander Holler)
Date: Mon, 17 Mar 2014 15:11:50 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <5326F8C5.5090406@ti.com>
References: <5316FFCE.1060603@ti.com>	<1394018461-757-1-git-send-email-holler@ahsoftware.de>	<CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>	<5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
Message-ID: <532702A6.9070309@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.03.2014 14:29, schrieb Sekhar Nori:

> One thing to note is that this driver is used by keystone too and all
> its users are DT-only. Although I do not see any in-kernel DT GPIO users
> even there.

Common gpio users are, as always, gpio-keys and gpio-leds. Doesn't have 
one of the keystone boards at least LEDs?

> I can confirm the patch does not break my gpiolib based test module
> (test with and without DT), but then it did not have an issue even before.

Thanks, maybe someone could add a

Cc: <stable@vger.kernel.org>

to get the fix back into 3.14 if it has go through -next.

Regards,

Alexander Holler
