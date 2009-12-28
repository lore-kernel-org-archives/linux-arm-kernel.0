From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 29 Dec 2009 00:03:06 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87vdfqx2xw.fsf@free.fr>
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>
	<87ocltsda3.fsf@free.fr>
	<20091223005313.13ba5061.ospite@studenti.unina.it>
	<87vdfqx2xw.fsf@free.fr>
Message-ID: <20091229000306.78948000.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Dec 2009 21:23:55 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> 
> > With your latest patch on top of 2.6.32 I get the "possible recursive
> > locking" message at the *first* cable unplug/plug cycle, I am appending
> > it here, the log is partial because I dumped it from RAM and something
> > was lost.
> 
> Thanks.
> Now, lets have another try. This patch is a bit saner, and though I got the
> "locking detected" you noticed without it, I didn't manage to get it with this
> patch applied.
> 
> As your test platform is far better than mine, would you mind a bit of testing
> ... again. This patch applies on top of v2.6.32.
>

Just FYI our repository has been updated to 2.6.33-rc2 and I haven't
been able to reproduce the message here yet _without_ the patch.
I'll go back to 2.6.32 and test again with and without this patch in
next days, and report promptly.

> Cheers.
> 
> --
> Robert
> 

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091229/3e2548c6/attachment.sig>
