From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Thu, 21 Nov 2013 11:13:48 +0800
Subject: [Inquiry] How to boot using USB device and configure PCI using
 OMAP4460/4470?
In-Reply-To: <20131119201617.GC4715@saruman.home>
References: <CAB8gEUt-_-w4wJkdo3bH7qiLOaqFusfL85rs58n00twD1qpxLA@mail.gmail.com>
 <20131114154505.GC15835@saruman.home>
 <CAB8gEUtYG9agU2i=fEKocfw1wjvBDfHvo5=fLNpABeNtFiXSxA@mail.gmail.com>
 <20131119201617.GC4715@saruman.home>
Message-ID: <CAB8gEUvbOeJedMUehtrDHy9YzHv-rU3CqiZO=FYGjqhGzS07LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,
Good morning.

> oh, that's a COM connector. It's used to interface with TI's WiLink
> devices.  The actual bus there is SDIO.
I see. So the interface used is SDIO.
Thank you for your confirmation.
We can now close this thread. :)

Regards,
Maj

On Wed, Nov 20, 2013 at 4:16 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Nov 19, 2013 at 09:47:42AM +0800, Maggie Mae Roxas wrote:
>> Hi Felipe,
>> Good morning.
>>
>> Thank you very much for the feedback.
>>
>> > all you need to do is write a flasher and a small "bootloader" which
>> > knows about usb. ROM code can receive data via USB and jump to that
>> > data's entry point.
>> > It's all in the TRM.
>> OK, I will look into this.
>> However, it seems like this question (1) is not kernel-related.
>> Can you direct me to the correct contact person for this?
>>
>> > that's because OMAP4 doesn't have a PCI controller.
>> But TI OMAP4470 Blaze Tablet 2 Development Platform contains PCI (miniPCIe).
>> How is Blaze 2 tablet's kernel configured then..?
>
> oh, that's a COM connector. It's used to interface with TI's WiLink
> devices.  The actual bus there is SDIO.
>
> --
> balbi
