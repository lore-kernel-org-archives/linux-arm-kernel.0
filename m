From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 16 Apr 2014 14:23:23 +0200
Subject: [PATCH] ARM i.MX51: Add Efika MX Smartbook devicetree
In-Reply-To: <1397650038.299778344@f431.i.mail.ru> (Alexander Shiyan's message
 of "Wed, 16 Apr 2014 16:07:18 +0400")
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
 <87tx9to71v.fsf@lebrac.rtp-net.org>
 <1397650038.299778344@f431.i.mail.ru>
Message-ID: <87ppkho43o.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shiyan <shc_work@mail.ru> writes:

> Wed, 16 Apr 2014 13:19:40 +0200 ?? Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>:
>> Alexander Shiyan <shc_work@mail.ru> writes:
>> 
>> > This patch adds support for Efika MX Smartbook.
>> 
>> I'm curious, how did you test that ? From a very quick look,
>> seems it has no chance to work with the uboot shipped with the devices.
>
> Uboot it is not the only option for booting.
> With any loader, this can be used with "appended DTB" option in the kernel.
>
> This board support was be introduced by Sascha Hauer for the "barebox".
> So I think he was checking its workability.

As I said, I'm talking of the uboot shipped with the devices. I do know
that barebox is doing things differently than this uboot. For
instance, with this DTB and barebox, usb should(?) work but for sure, it
won't work with this uboot.
If we merge something, it should work with all bootloaders otherwise it
would mean that the dtb is bootloader specific...

Arnaud
