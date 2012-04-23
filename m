From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 23 Apr 2012 01:57:22 +0000
Subject: [PATCH 11/11] MXS: Enable USB on M28EVK
In-Reply-To: <1335099567-21056-12-git-send-email-marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335099567-21056-12-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B79445@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> Enable the second USB port on M28EVK board.
> 
 
> +
> +	mx28_add_mxs_usbh(0, &m28_usb_data);
>  }
> 
You have enabled second port at mx28evk, why it "0"? at your mx28_add_mxs_usbh(0, &m28_usb_data).


>  static void __init m28evk_timer_init(void)
> --
> 1.7.9.5
> 
