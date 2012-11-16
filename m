From: s.peter@mpl.ch (Stefan Peter)
Date: Fri, 16 Nov 2012 20:33:32 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <20121116163737.GD24569@lunn.ch>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116163737.GD24569@lunn.ch>
Message-ID: <50A6950C.1070408@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

On 16.11.2012 17:37, Andrew Lunn wrote:
> On Fri, Nov 16, 2012 at 11:10:22AM +0100, Stefan Peter wrote:
>>
>> Signed-off-by: Stefan Peter <s.peter@mpl.ch>
>>

>> diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
>> new file mode 100644
>> index 0000000..ea26b62
>> --- /dev/null
>> +++ b/arch/arm/mach-kirkwood/board-mplcec4.c
>> @@ -0,0 +1,82 @@
>> +/*
>> + * Copyright (C) 2012 MPL AG, Switzerland
>> + * Stefan Peter <s.peter@mpl.ch>
>> + *
>> + * arch/arm/mach-kirkwood/board-mplcec4.c
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-private.h>
> 
> Hi Stefan
> 
> Are these two clk headers needed?
> 
>     Andrew
> 

I don't know, but i will find out and let you know in V2.

Thank you very much for the review.


Regards

Stefan Peter

-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
