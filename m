From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Nov 2018 11:55:08 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Add and enable
 CAN,FD device nodes
In-Reply-To: <63e27a31-d599-4672-87b9-48b0f542313d@gmail.com>
References: <20181118173424.4807-1-marek.vasut+renesas@gmail.com>
 <20181118230313.GB2553@kunai>
 <63e27a31-d599-4672-87b9-48b0f542313d@gmail.com>
Message-ID: <20181119105508.GC932@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Same here, what was tested?
> 
> I connected the CN10 to Peak CANFD, brought both interfaces up at
> 125kBd/250kBd for FD
> $ ip link set canX up type can bitrate 125000 dbitrate 250000 fd on
> 
> And ran on either side:
> $ cangen -m canX
> and
> $ candump -t d -dex canX
> This should give a good mix of CAN messages.

Perfect, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/5ade715d/attachment.sig>
