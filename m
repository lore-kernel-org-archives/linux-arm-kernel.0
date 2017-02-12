From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 12 Feb 2017 02:15:43 +0100
Subject: [BUG] usb: gadget: Kernel oops with UVC USB gadget and configfs
In-Reply-To: <87shnt1sue.fsf@belgarion.home>
References: <497c3c61-31f0-4d40-9bab-5a0aa793e5e9@tul.cz>
 <87shnt1sue.fsf@belgarion.home>
Message-ID: <3faadfcb-5e0d-8f92-3e91-4bd745026644@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

any news?

Petr

Dne 4.2.2017 v 23:42 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Setting the UVC gadget with configfs and then reloading UDC controler driver
>> (pxa27x_udc) causes kernel to fail.
>>
>> UDC subsystem was patched only in decreasing maxpacket size for UVC, addition
>> of more predefined endpoints for pxa27x_udc and addition of some debugging pr_info.
>>
>> Practically same behaviour was observed on 4.7.0 too.
> Hi Petr,
> 
> If you could provide me your "debug patch" for the new endpoints, packet size
> and pr_infos, I could try to reproduce on my platform and have a look.
> 
> I must say that I'm not familiar with uvc, so I can only suppose you're trying
> to stream the magician camera to USB to "act" like a Webcam, is it what you're
> trying to achieve ?
> 
> Cheers.
> 
> --
> Robert
> 
