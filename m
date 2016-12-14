From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 14 Dec 2016 13:53:23 +0100
Subject: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
In-Reply-To: <201612141321.30181@pali>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth> <20161019092506.GA1461@amd>
 <201612141321.30181@pali>
Message-ID: <20161214125323.GA4951@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > [  220.248596] tty ttyO1: Radio packet sent
> > [  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
> > [  220.272949] tty ttyO1: wakeup received: 1 -> 0
> > [  221.283477] tty ttyO1: radio packet timeout!
> > [  221.283630] enqueue: hu c304cc80 skb cd4a9b40
> > [  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
> > pavel at n900:~$
> 
> In log are still some failures, but ... is bluetooth working now?

It is... for Sebastian. I'm playing with camera now.

> I see that you applied this patch: 
> https://git.kernel.org/cgit/linux/kernel/git/pavel/linux-n900.git/commit/?id=051aa3fbf03ac770d8344690f5a936a7f04c6884
> 
> Looks like that pinmux is in DTS file incorrect. Can somebody verify it? 
> Maybe Tony?

Yes, it is. Sebastian was pretty certain about that.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/615b77da/attachment-0001.sig>
