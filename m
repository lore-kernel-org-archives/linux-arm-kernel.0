From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 22 Mar 2012 16:53:13 -0400
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <4F6B7226.8000102@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
 <4F6B7226.8000102@wwwdotorg.org>
Message-ID: <201203221653.19268.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 March 2012 14:40:38 Stephen Warren wrote:
> On 03/16/2012 03:03 PM, Stephen Warren wrote:
> > All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> > to avoid duplication.
> > 
> > All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> > parameterized version in Makefile.lib to avoid duplication.
> 
> Does this change look reasonable? It has acks from people working on 4
> of the 7 affected architectures; would you prefer acks from all?

isn't that what linux-next is for ? ;)
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120322/ceac9709/attachment.sig>
