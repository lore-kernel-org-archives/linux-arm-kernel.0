From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 23 May 2014 14:35:19 -0400
Subject: [Patch v7 2/7] clock: keystone-pllctrl: add bindings for keystone
 pll controller
In-Reply-To: <20140523183218.23136.51518@quantum>
References: <1400859812-5761-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400859812-5761-3-git-send-email-ivan.khoronzhuk@ti.com>
 <20140523183218.23136.51518@quantum>
Message-ID: <537F94E7.5040907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014 02:32 PM, Mike Turquette wrote:
> Quoting Ivan Khoronzhuk (2014-05-23 08:43:27)
>> The main pll controller used to drive theC66x CorePacs, the switch fabric,
>> and a majority of the peripheral clocks (all but the ARM CorePacs, DDR3 and
>> the NETCP modules) requires a PLL Controller to manage the various clock
>> divisions, gating, and synchronization.
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> 
Thanks Mike !!
