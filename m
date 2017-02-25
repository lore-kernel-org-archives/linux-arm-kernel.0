From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Feb 2017 13:21:07 +0100
Subject: [PATCH v2 1/2] usb: gadget: pxa27x: Remove duplicate function
 prototype
In-Reply-To: <9f125a32-1d2a-54ea-ccd8-8d8b494c6f3a@tul.cz> (Petr Cvek's
 message of "Fri, 24 Feb 2017 02:54:12 +0100")
References: <cover.1487901100.git.petr.cvek@tul.cz>
 <9f125a32-1d2a-54ea-ccd8-8d8b494c6f3a@tul.cz>
Message-ID: <87wpcewjf0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Functions udc_enable() and udc_disable() have a duplicated prototype.
> Remove it.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
