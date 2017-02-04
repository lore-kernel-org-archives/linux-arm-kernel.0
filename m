From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 04 Feb 2017 23:42:01 +0100
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
In-Reply-To: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz> (Petr Cvek's
 message of "Tue, 24 Jan 2017 16:14:07 +0100")
References: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
Message-ID: <87shnt1sue.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Setting the UVC gadget with configfs and then reloading UDC controler driver
> (pxa27x_udc) causes kernel to fail.
>
> UDC subsystem was patched only in decreasing maxpacket size for UVC, addition
> of more predefined endpoints for pxa27x_udc and addition of some debugging pr_info.
>
> Practically same behaviour was observed on 4.7.0 too.
Hi Petr,

If you could provide me your "debug patch" for the new endpoints, packet size
and pr_infos, I could try to reproduce on my platform and have a look.

I must say that I'm not familiar with uvc, so I can only suppose you're trying
to stream the magician camera to USB to "act" like a Webcam, is it what you're
trying to achieve ?

Cheers.

--
Robert
