From: david.lanzendoerfer@o2s.ch (David =?iso-8859-1?q?Lanzend=F6rfer?=)
Date: Fri, 3 Sep 2010 19:30:37 +0200
Subject: Keyboard for HTC-Dream
In-Reply-To: <4C8117DA.8070605@codeaurora.org>
References: <201008071307.40988.david.lanzendoerfer@o2s.ch>
	<201009031701.34609.david.lanzendoerfer@o2s.ch>
	<4C8117DA.8070605@codeaurora.org>
Message-ID: <201009031930.45513.david.lanzendoerfer@o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>You're using an older submission of gpiolib which doesn't support 
>dual-edge IRQs.  That one has been scrapped in favor of the one from 
>android's 2.6.35-wip branch. It hasn't been accepted yet, and is 
>currently being discussed on the mailing lists.  If you search the 
>mailing list archives from the past two weeks you'll find the patches.
Thx a lot!
I'll try it.
With keyboard+touchscreen+wheel and usbethernet I'll have something
which will GNUtoo to help me port the rest of the drivers I guess ^_^

big thanks and best regards
	leviathan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100903/c2fd3dde/attachment.sig>
