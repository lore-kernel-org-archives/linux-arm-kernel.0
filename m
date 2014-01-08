From: rogerq@ti.com (Roger Quadros)
Date: Wed, 8 Jan 2014 17:18:45 +0530
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <201401081235.40927.arnd@arndb.de>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <3761842.HRY1CDBF4z@wuerfel> <52CD324D.3020701@ti.com>
 <201401081235.40927.arnd@arndb.de>
Message-ID: <52CD3B1D.5080203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2014 05:05 PM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, Roger Quadros wrote:
>> OK. I'll update the binding information to reflect all the clocks.
>>
>> But what about clk_get() vs of_clk_get_by_name() ?
> 
> I think the convention these days is to just use clk_get(), which calls
> of_clk_get_by_name() internally. Not sure if that's what you are asking.
>

OK fine. I'll continue to use clk_get() then.

cheers,
-roger
