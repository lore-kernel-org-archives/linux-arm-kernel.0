From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Sep 2013 17:33:29 -0700
Subject: [PATCH] ARM: vexpress: allow dcscb and tc2_pm in a combined
 ARMv6+v7 build
In-Reply-To: <alpine.LFD.2.03.1309091224010.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091224010.20709@syhkavp.arg>
Message-ID: <20130910003329.GA31153@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 12:31:04PM -0400, Nicolas Pitre wrote:
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


Applied to fixes. thanks!


-Olof
