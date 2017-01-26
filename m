From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 26 Jan 2017 10:15:04 +0100
Subject: [PATCH] usb: gadget: udc: constify usb_ep_ops structures
In-Reply-To: <1485192364-2840-1-git-send-email-bhumirks@gmail.com> (Bhumika
 Goyal's message of "Mon, 23 Jan 2017 22:56:04 +0530")
References: <1485192364-2840-1-git-send-email-bhumirks@gmail.com>
Message-ID: <878tpychd3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bhumika Goyal <bhumirks@gmail.com> writes:

> Declare usb_ep_ops structures as const as they are only stored in the
> ops field of an usb_ep structure. This field is of type const, so
> usb_ep_ops structures having this property can be made const too.
> Done using Coccinelle( A smaller version of the script)

For pxa27x_udc.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
