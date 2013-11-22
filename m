From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Nov 2013 23:09:00 +0100
Subject: crypto dependency in bit sliced AES
Message-ID: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

To my surprise, Linus has decided to release 3.13-rc1 without honoring
Herbert's crypto pull requests for 3.13

http://marc.info/?l=linux-crypto-vger&m=138381130023859&w=2
http://marc.info/?l=linux-crypto-vger&m=138482768727213&w=2

which contain my patch 'crypto: create generic version of ablk_helper'

https://git.kernel.org/cgit/linux/kernel/git/herbert/crypto-2.6.git/commit/?id=a62b01cd6cc1feb5e80d64d6937c291473ed82cb

I can only guess what the reason is (probably something as simple as
the word PULL missing from the subject line), but it does mean that
the bit sliced AES code still does not build, unfortunately.

Regards,
Ard.
