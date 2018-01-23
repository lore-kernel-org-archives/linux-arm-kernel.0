From: philippe.cornu@st.com (Philippe CORNU)
Date: Tue, 23 Jan 2018 10:25:51 +0000
Subject: [PATCH] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
In-Reply-To: <3169703.7pajs7FEnH@avalon>
References: <20180122102608.12565-1-philippe.cornu@st.com>
 <3169703.7pajs7FEnH@avalon>
Message-ID: <2bf185e2-9b02-3632-dc9a-baf8f4109b44@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

A big *thank* for your review

On 01/23/2018 12:30 AM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Monday, 22 January 2018 12:26:08 EET Philippe Cornu wrote:
>> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
>> host controller driver.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>> 46b0e73404d1..e06836dec77c 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -1,12 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> According to Documentation/process/license-rules.txt this would change the
> existing license. The correct identifier is GPL-2.0+.
> 

You are right, I did not put the correct identifier :(

After reading more spdx.org, I wonder if the correct value should be 
GPL-2.0-or-later instead of GPL-2.0+

https://spdx.org/licenses/GPL-2.0-or-later.html
https://spdx.org/licenses/GPL-2.0+.html

What is your opinion?

Many thanks,
Philippe :-)

>>   /*
>>    * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>    * Copyright (C) STMicroelectronics SA 2017
>>    *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>>    * Modified by Philippe Cornu <philippe.cornu@st.com>
>>    * This generic Synopsys DesignWare MIPI DSI host driver is based on the
>>    * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.
> 
> 
