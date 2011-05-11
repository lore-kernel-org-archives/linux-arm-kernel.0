From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 11 May 2011 12:26:56 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <20110510220214.916621d1.ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
	<20110510220214.916621d1.ospite@studenti.unina.it>
Message-ID: <20110511122656.de4cfbec.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 May 2011 22:02:14 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:
 
> I was blindly trusting code already in mainline again, and for that I
> apologize, I finally took the time to look at the implementation
> of IS_ERR() and test its use, and being IS_ERR(NULL) true it is not what
> we want indeed, see the attached test program.
> 

Just for the records, I meant to say "being IS_ERR(NULL) _false_" but
you got it anyways.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110511/8314eb4a/attachment.sig>
