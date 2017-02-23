From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 23 Feb 2017 08:28:13 +0100
Subject: [PATCH 2/2] usb: gadget: Add test if argument pointer has a valid
 value in pxa27x_udc
In-Reply-To: <3c2b75a6-55ec-bf5e-1f84-4c9a50e04660@tul.cz> (Petr Cvek's
 message of "Thu, 23 Feb 2017 02:35:26 +0100")
References: <cover.1487812323.git.petr.cvek@tul.cz>
 <3c2b75a6-55ec-bf5e-1f84-4c9a50e04660@tul.cz>
Message-ID: <87ino1xt6a.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Move call usb_put_phy(udc->transceiver) inside a valid pointer test.
>
> Reported-by: robert.jarzmik at free.fr
I'd rather have my normal signature here :
Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>

> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
