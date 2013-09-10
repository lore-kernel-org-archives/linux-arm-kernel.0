From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 9 Sep 2013 17:37:41 -0700
Subject: [PATCH] ARM: vexpress: allow dcscb and tc2_pm in a combined
 ARMv6+v7 build
In-Reply-To: <alpine.LFD.2.03.1309091224010.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091224010.20709@syhkavp.arg>
Message-ID: <CAGa+x84k0O-0EZrCf0yt0G1fNbs0y8qcvpW5x9-96uxFoxB9RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 9:31 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> This fixes the following build error:
>
> /tmp/cce439dZ.s: Assembler messages:
> /tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode `dsb '
> /tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode `isb '
> /tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode `dsb '
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Tested-by: Kevin Hilman <khilman@linaro.org>

Nice!  this helps quiet down allmodconfig builds.

Kevin
