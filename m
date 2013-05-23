From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 23 May 2013 10:23:27 +0800
Subject: [PATCH 1/7] USB: gadget: atmel_usba: move global struct usba_ep
 usba_ep to struct usba_udc
In-Reply-To: <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <519D7D9F.1070109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 5/21/2013 00:25, Jean-Christophe PLAGNIOL-VILLARD wrote:
> so we can have multiple usb gadget instance
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org

For this series, test OK on at91sam9m10g45ek and at91sam9x5ek board
Tested-by: Bo Shen <voice.shen@atmel.com>

PS: When do testing, we need build in or choose as module: "Device 
Drivers ---> Generic Target Core Mod (TCM) and ConfigFS infrastructure"

Best Regards,
Bo Shen
