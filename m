From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 19 Apr 2018 10:41:03 +0000
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
In-Reply-To: <101210971.aHjggv2rq0@avalon>
References: <20180208145805.24762-1-philippe.cornu@st.com>
 <101210971.aHjggv2rq0@avalon>
Message-ID: <c55dab05-8003-ea5b-58f9-39aaa861fab6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applied on drm-misc-next.
Many thanks,
Philippe :-)

On 02/08/2018 05:46 PM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Thursday, 8 February 2018 16:58:05 EET Philippe Cornu wrote:
>> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
>> host controller driver.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>> Changes in v2: Update to "GPL-2.0+" following comments from Laurent
>> Pinchart, Benjamin Gaignard & Philippe Ombredanne.
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>> 7bac101c285c..99f0e4f51716 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -1,12 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
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
