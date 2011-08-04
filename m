From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 11:17:50 +0200
Subject: No mach-type for SHEEVAD?
Message-ID: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tried to configure the mmp2 to build the "gplugd" variant
found in the arch/arm/mach-mmp2/gplugd.c source file,
however it fails miserably:

arch/arm/mach-mmp/gplugd.c:183: error: 'MACH_TYPE_SHEEVAD' undeclared
here (not in a function)
make[3]: *** [arch/arm/mach-mmp/gplugd.o] Error 1

Which is not strange given that it's not in mach-types.
Nor does it appear to ever have been there, and I wonder
if it was ever submitted to Russells machine registry.

Can the subarch maintainers tell us how to deal with this,
say like delete the boardfile or add the machine type?

Thanks,
Linus Walleij
