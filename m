From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 3 Mar 2014 17:46:34 +0100
Subject: [PATCH] usb: gadget: atmel_usba: fix crash when no endpoint are
 specified
In-Reply-To: <53109EBE.4020900@atmel.com>
References: <1393515733-15764-1-git-send-email-alexandre.belloni@free-electrons.com>
 <53109EBE.4020900@atmel.com>
Message-ID: <20140303164633.GB3155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On 28/02/2014 at 15:35:42 +0100, Nicolas Ferre wrote :
> On 27/02/2014 16:42, Alexandre Belloni :
> > If no endpoints are present in the device tree, the kernel will cras hwith the
> 
> s/cras hwith/crash with/
> 

Do you want me to send a v2 with that typo corrected or could you
correct it when applying ?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
