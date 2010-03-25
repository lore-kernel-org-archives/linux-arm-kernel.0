From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Thu, 25 Mar 2010 14:26:01 -0400
Subject: [PATCH 2/2] ARM: pcmcia: fix checkpatch.pl issues in soc_common.c
In-Reply-To: Your message of "Thu, 25 Mar 2010 13:19:29 +0300."
	<4BAB38B1.8080404@ru.mvista.com>
References: <1269471898-26301-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<1269471898-26301-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100324230729.GA21359@n2100.arm.linux.org.uk>
	<4BAB38B1.8080404@ru.mvista.com>
Message-ID: <9610.1269541561@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Mar 2010 13:19:29 +0300, Sergei Shtylyov said:

>    I'd disagree in this case. Anybody will hardly grep for "mask: 
> %s%s%s%s%s%sflags: %s%s%s%s%s%s".

However,  egrep 'mask: .*flags: ' is quite plausible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100325/d84a7233/attachment.sig>
