From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 9 May 2014 07:06:10 +0200
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <536C1945.1000601@cogentembedded.com>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
 <536C1945.1000601@cogentembedded.com>
Message-ID: <20140509050610.GB2624@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >+	eeprom at 50 {
> >+		compatible = "renesas,24c02";
> 
>    This is not quite right: Renesas' part is called differently, and
> you're carrying the other vendor's naming onto Renesas parts. I'd
> just say "24c02" (which I'll do in the Henninger board patch).

What about "generic"?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/ed4c0d4f/attachment.sig>
