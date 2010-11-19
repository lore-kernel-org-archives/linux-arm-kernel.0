From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Nov 2010 23:32:18 +0100
Subject: U300/Ux500/Nomadik combine pull requests?
Message-ID: <AANLkTi==88zHGZ8r5Lto+i=PfT3vbiFfxWrBCpjb7JKo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

we're probably going to be stacking up a few patches for .38 in the combined
U300/Ux500/Nomadik series.

Is it OK if we remove the patches to plat-nomadik, mach-u300, mach-ux500
and mach-nomdik from the patch tracker and issue a pull request to you
towards the end of the kernel cycle like others do?

That'd currently be:
6374/1
6397/1
6473/1
6488/1

+ whatever gets sent for review and reach some consensus until
the next pre-merge phase.

The last patch there I should maybe even ask Linus (the other one)
to pull directly for the -rc:s, that seems to be the process...

Yours,
Linus Walleij
