From: ruslan.bilovol@gmail.com (Ruslan Bilovol)
Date: Sat, 26 Mar 2016 23:41:06 +0200
Subject: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
In-Reply-To: <20160325211542.GA11978@amd>
References: <20160317212603.GA16651@amd>
 <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
 <20160318202041.GA20196@amd> <56EFE057.7070106@samsung.com>
 <20160323122143.GB32031@amd>
 <CAB=otbT2VsZ8Rhc-jbKwtRAssn01ecVFyTyAp+5hS=d40AsGKA@mail.gmail.com>
 <CAB=otbQdpEtsXg2etX+3YYjrTfPYGtdKJo_V_rtfNb+VNV7g-w@mail.gmail.com>
 <20160325211542.GA11978@amd>
Message-ID: <CAB=otbRd+hZaO6ihL3c88Ys_q-R4grmup4cfP70PT+N2JEQ3WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, Mar 25, 2016 at 11:15 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> OK, so at last I finished charging of my N900; found 1.8V USB
>> to UART adapter and soldered it to the phone.
>>
>> I managed to boot N900 with working USB gadget (builtin g_ether)
>> in boardfile mode, can ping it from PC and transfer data. I don't
>> see any issue (except of musb name issue in twl phy driver, I've
>> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
>
> I tried to add that one, too, and no change. Can I get your .config?

Since you use DT boot, this patch will not have any effect.
See my config attached.

Please note that I'm building simple rootfs cpio binary into the kernel
so you may need to change CONFIG_INITRAMFS_SOURCE value

Best regards,
Ruslan

>
> Thanks and best regards,
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/x-gzip
Size: 25848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160326/6f3e20f8/attachment-0001.bin>
