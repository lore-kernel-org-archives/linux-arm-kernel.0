From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Feb 2017 13:24:22 +0100
Subject: [PATCH v2 2/2] usb: gadget: pxa27x: Test for a valid argument
 pointer
In-Reply-To: <e794578c-8805-691f-27bc-f07880013fa1@tul.cz> (Petr Cvek's
 message of "Fri, 24 Feb 2017 02:54:56 +0100")
References: <cover.1487901100.git.petr.cvek@tul.cz>
 <e794578c-8805-691f-27bc-f07880013fa1@tul.cz>
Message-ID: <87shn2wj9l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> A call usb_put_phy(udc->transceiver) must be tested for a valid pointer.
> Use an already existing test for usb_unregister_notifier call.
>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
