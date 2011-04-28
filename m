From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Wed, 27 Apr 2011 20:15:29 -0400
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: Your message of "Wed, 27 Apr 2011 12:08:28 BST."
	<1303902508.15101.21.camel@e102109-lin.cambridge.arm.com>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
	<201104271243.16868.arnd@arndb.de>
	<1303902508.15101.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <11431.1303949729@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011 12:08:28 BST, Catalin Marinas said:

> The current version of the ARM ARM says "unpredictable". But this
> general definition of "unpredictable" does not allow it to deadlock
> (hardware) or have security implications. It is however allowed to
> corrupt data.

Not allowed to have security implications, but is allowed to corrupt data.

*boggle* :)

(The problem being, of course, that if the attacker is able to predict/control
what gets corrupted, it can easily end up leveraged into a security implication.)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110427/4722e31a/attachment.sig>
