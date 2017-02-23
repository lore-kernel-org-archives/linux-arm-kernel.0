From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 23 Feb 2017 08:30:40 +0100
Subject: [PATCH 1/2] [TRIVIAL] usb: gadget: Remove duplicated function
 declaration in pxa27x_udc
In-Reply-To: <4234ff1b-66f3-0be0-ea62-75d622abb044@tul.cz> (Petr Cvek's
 message of "Thu, 23 Feb 2017 02:35:12 +0100")
References: <cover.1487812323.git.petr.cvek@tul.cz>
 <4234ff1b-66f3-0be0-ea62-75d622abb044@tul.cz>
Message-ID: <87efypxt27.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Remove duplicated function declaration for udc_enable() and udc_disable().

The patch title looks a bit tool long to me, and that also applied to your
second one.

Moreover the correct prefix for this driver (for the title) is :
         usb: gadget: pxa27x: MySuperSyntheticTitle

Cheers.

-- 
Robert
