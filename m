From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 25 Apr 2018 12:53:43 +0300
Subject: [PATCH 1/3] usb: gadget: udc: atmel: GPIO inversion is handled by
 gpiod
In-Reply-To: <20180416093405.16612-2-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
 <20180416093405.16612-2-romain.izard.pro@gmail.com>
Message-ID: <87wowvhas8.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Romain Izard <romain.izard.pro@gmail.com> writes:

> When converting to GPIO descriptors, gpiod_get_value automatically
> handles the line inversion flags from the device tree.
>
> Do not invert the line twice.
>
> Fixes: 3df034081021fa4b6967ce3364bc7d867ec1c870

your fixes line is incorrect. Please fix and resend. While at that,
please collect Acked-bys and Tested-bys, etc.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/d7365672/attachment.sig>
