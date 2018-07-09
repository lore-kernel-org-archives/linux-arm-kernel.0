From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 9 Jul 2018 18:55:01 +0300
Subject: [PATCH v5 2/5] clk: at91: add I2S clock mux driver
In-Reply-To: <153090076533.143105.11588903392800697432@swboyd.mtv.corp.google.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-3-codrin.ciubotariu@microchip.com>
 <153090076533.143105.11588903392800697432@swboyd.mtv.corp.google.com>
Message-ID: <b7a379b3-0cfe-7a8e-fa13-3d152beb5e32@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.07.2018 21:12, Stephen Boyd wrote:
> Quoting Codrin Ciubotariu (2018-06-18 07:12:36)
>> This driver is a simple muxing driver that controls the
>> I2S's clock input by using syscon/regmap to change the parent.
>> The available inputs can be peripheral clock and generated clock.
>>
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
> 
> Applied to clk-next
> 
> But I had to fix:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #56: FILE: drivers/clk/at91/clk-i2s-mux.c:1:
> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> so I did. Please run checkpatch next time.
> 

Sorry about that. I did run checkpatch, but I saw some files that 
commented the License-Identifier the same way I did. Didn't notice back 
then that were only the headers...
Thank you for applying my patches.

Best regards,
Codrin
