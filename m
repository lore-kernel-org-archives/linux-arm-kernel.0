From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 17 Jan 2010 20:33:43 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <20100117134138.8d814ed6.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Sun\, 17 Jan 2010 13\:41\:38 +0100")
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87fx7guuzg.fsf@free.fr>
	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>
	<87ocltsda3.fsf@free.fr>
	<20091223005313.13ba5061.ospite@studenti.unina.it>
	<87vdfqx2xw.fsf@free.fr>
	<20091229000306.78948000.ospite@studenti.unina.it>
	<20100117134138.8d814ed6.ospite@studenti.unina.it>
Message-ID: <87my0ca5m0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Hi Robert,
>
> Only today I've found some time to test the patch in a 2.6.32 setup, I
> am not able to reproduce the issue with your latest patch _applied_,
> while it it still there with unpatched code, so I'd say it is an
> improvement.
Thanks for your time.
I'll submit it to the usb mailing list for review.

Cheers.

--
Robert
