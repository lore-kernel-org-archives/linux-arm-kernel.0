From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 06 Dec 2011 15:25:42 +0400
Subject: [PATCH] USB: pxa168: Fix compilation error
In-Reply-To: <1323169667-10671-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <no>
 <1323169667-10671-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <4EDDFBB6.5060803@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06-12-2011 15:07, Tanmay Upadhyay wrote:

> After commit c430131a02d677aa708f56342c1565edfdacb3c0,

   Please also specify that commit's summary in parens.

> HC_LENGTH takes two arguments. This patch fixes following
> compilation error:

> In file included from drivers/usb/host/ehci-hcd.c:1323:
> drivers/usb/host/ehci-pxa168.c:302:54: error: macro "HC_LENGTH" requires 2 arguments, but only 1 given
> In file included from drivers/usb/host/ehci-hcd.c:1323:
> drivers/usb/host/ehci-pxa168.c: In function 'ehci_pxa168_drv_probe':
> drivers/usb/host/ehci-pxa168.c:302: error: 'HC_LENGTH' undeclared (first use in this function)
> drivers/usb/host/ehci-pxa168.c:302: error: (Each undeclared identifier is reported only once
> drivers/usb/host/ehci-pxa168.c:302: error: for each function it appears in.)

> Signed-off-by: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>

WBR, Sergei
