From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Thu, 25 Mar 2010 17:16:35 +0100
Subject: [BUG] i.MX25: Broken include in mach-mx25pdk.c
Message-ID: <20100325161635.GI2328@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

compiling arch/arm/mach-mx25/mach-mx25pdk.c fails due to the missing
include "linux/fec.h" and incomplete types that are supposed to
defined in this header

i'd send a fix, but greping through the kernel tree i haven't been
able to identify the file defining the missing elements, i suppose it's still
sitting bored in some development tree waiting to be merged

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

            Nothing is more despicable than respect based on fear
                              (Albert Camus)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
