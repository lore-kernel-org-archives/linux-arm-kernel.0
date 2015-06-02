From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 3 Jun 2015 00:36:28 +0900
Subject: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative
 command
In-Reply-To: <20150602152647.GA2806@odux.rfo.atmel.com>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <20150602152647.GA2806@odux.rfo.atmel.com>
Message-ID: <20150602153622.GB2661@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> If you send a new version, could you add stable in Cc to patch 3/6:

No need to send a new version just because of an additional ack. I can
apply that. However...

> Cc: stable at vger.kernel.org #3.10 and later
> If not, Wolfram could you do it please?

The problem with 3/6 is that it seems to depend on 1/6 which is a
cleanup patch. If cleaning up is not essential for the bugfix, the
latter should be done first. To avoid exactly this problem.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/7f8670ee/attachment.sig>
