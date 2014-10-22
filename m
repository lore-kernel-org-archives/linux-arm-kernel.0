From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 22 Oct 2014 18:08:01 +0200
Subject: [PATCH v2] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
References: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141022160800.GB1895@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>     I'm wondering whether this can be fixed in the i2c driver? Does it
>     really have to enable and disable the clock?

>From a power-saving PoV, this makes sense. I assume serial output works
again as soon as the regular scif driver takes over? Isn't that a
generic problem of early_printk drivers that they are not refcounted for
the clocks?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141022/99784f34/attachment.sig>
