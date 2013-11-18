From: bgamari.foss@gmail.com (Ben Gamari)
Date: Mon, 18 Nov 2013 14:08:58 -0500
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
In-Reply-To: <20131118185722.GS10317@atomide.com>
References: <87hab9agjr.fsf@gmail.com> <20131118185722.GS10317@atomide.com>
Message-ID: <874n79plx1.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Ben Gamari <bgamari.foss@gmail.com> [131118 07:14]:
>> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
>> linux-next (30121118). I'm booting with a brand new u-boot
>> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
>> 
>> In both cases the device appears to hang shortly before one would expect
>> init to start as seen in the boot output below. I'm booting with the
>> omap4-panda-es devicetree. As far as I can tell, the machine is
>> completely dead and will not respond to even sysrq. I have a PandaBoard
>> A4 which apparently has no trouble with the same kernel image.
>
> Do you have the same version of u-boot in both cases?
>
Yes.

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/cda473f7/attachment-0001.sig>
