From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 11:11:23 +0100
Subject: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <alpine.DEB.2.02.1308130652080.1997@localhost6.localdomain6>
References: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
 <20130812214050.GI6427@sirena.org.uk>
 <alpine.DEB.2.02.1308130652080.1997@localhost6.localdomain6>
Message-ID: <20130813101123.GP6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 06:52:56AM +0200, Julia Lawall wrote:
> On Mon, 12 Aug 2013, Mark Brown wrote:

> > What is the difference between this and the patch I applied the other
> > day?

> Sorry, it should have also removed the local definition of ARRAY_AND_SIZE?  
> I thought that was in the commit message.

It was, sorry - to be hoenst I didn't read beyond the first paragraph
since I'd already applied the patch.  If a patch has been applied you
should really send incremental updates rather than resending the patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/08652c2d/attachment.sig>
