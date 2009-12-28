From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 28 Dec 2009 21:23:55 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <20091223005313.13ba5061.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Wed\, 23 Dec 2009 00\:53\:13 +0100")
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>
	<87ocltsda3.fsf@free.fr>
	<20091223005313.13ba5061.ospite@studenti.unina.it>
Message-ID: <87vdfqx2xw.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> With your latest patch on top of 2.6.32 I get the "possible recursive
> locking" message at the *first* cable unplug/plug cycle, I am appending
> it here, the log is partial because I dumped it from RAM and something
> was lost.

Thanks.
Now, lets have another try. This patch is a bit saner, and though I got the
"locking detected" you noticed without it, I didn't manage to get it with this
patch applied.

As your test platform is far better than mine, would you mind a bit of testing
... again. This patch applies on top of v2.6.32.

Cheers.

--
Robert
