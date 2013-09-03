From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Sep 2013 14:01:45 +0200
Subject: Inte IOP Xscale updates
Message-ID: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi XScale folks,

I haven't really seen any functional patches or confirmation that the
XScale machines in arch/arm/iop* are even booting since 2010 or
so.

Can you confirm that you boot-test these machines regularly?

I am worried that we maintain code that is not used or even working
see.

What are your thought about multiplatform and device tree? I am
pretty certain that if the iop machines were converted to device tree
we could collapse these machines into one directory with few files,
but I may be wrong.

Yours,
Linus Walleij
