From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 May 2013 12:22:32 +0200
Subject: [PATCH 1/7] USB: gadget: atmel_usba: move global struct usba_ep
 usba_ep to struct usba_udc
In-Reply-To: <519D7D9F.1070109@atmel.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
 <519D7D9F.1070109@atmel.com>
Message-ID: <519DEDE8.3040503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2013 04:23, Bo Shen :
> Hi J,
>
> On 5/21/2013 00:25, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> so we can have multiple usb gadget instance
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: linux-usb at vger.kernel.org
>
> For this series, test OK on at91sam9m10g45ek and at91sam9x5ek board
> Tested-by: Bo Shen <voice.shen@atmel.com>

After reading this v4 series, it seems good. So, on the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> PS: When do testing, we need build in or choose as module: "Device
> Drivers ---> Generic Target Core Mod (TCM) and ConfigFS infrastructure"

Thanks a lot to you, Bo and Jean-Christophe.

Bye,
-- 
Nicolas Ferre
