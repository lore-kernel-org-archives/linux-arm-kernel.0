From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Mar 2014 15:05:05 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <5326F8C5.5090406@ti.com>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
 <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
 <5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
Message-ID: <CACRpkdYZMzw31NkA4uSq+ZowzOnZgZthXhZri-eJY2Ozb8aNRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 2:29 PM, Sekhar Nori <nsekhar@ti.com> wrote:

> One thing to note is that this driver is used by keystone too and all
> its users are DT-only. Although I do not see any in-kernel DT GPIO users
> even there.
>
> I can confirm the patch does not break my gpiolib based test module
> (test with and without DT), but then it did not have an issue even before.

Is that a Tested-by tag? :-)

If you're also convinced that fix is safe I'll push it as a fix to v3.14-rcN
if for nothing else so for getting Mr. Holler to stop poking me in the
chest.

Yours,
Linus Walleij
