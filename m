From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 6 Feb 2018 14:54:29 +0100 (CET)
Subject: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <20180206135310.deiaz55xemc26xn4@ninjato>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
 <20180206131044.oso33fvv553trrd7@mwanda>
 <alpine.DEB.2.20.1802061414340.3306@hadrien>
 <20180206132335.luut6em3kut7f7ej@mwanda>
 <alpine.DEB.2.20.1802061439110.3306@hadrien>
 <20180206135310.deiaz55xemc26xn4@ninjato>
Message-ID: <alpine.DEB.2.20.1802061453440.3306@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 6 Feb 2018, Wolfram Sang wrote:

> Hi Julia,
>
> > and got the results below.  I can make a version for the kernel shortly.
>
> It should probably take care of right-shifting, too?

I did that too but got no results.  Perhaps right shifting constants is
pretty uncommon.  I can put that in the complete rule though.

julia
