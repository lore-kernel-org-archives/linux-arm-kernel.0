From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 03 Mar 2011 09:24:31 +0100
Subject: [PATCH] ARM: mx51: Print silicon revision on boot
In-Reply-To: <1299114747-14091-1-git-send-email-festevam@gmail.com> (Fabio
	Estevam's message of "Wed, 2 Mar 2011 22:12:27 -0300")
References: <1299114747-14091-1-git-send-email-festevam@gmail.com>
Message-ID: <87lj0wwr0g.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:
Hi,

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Why I like having boot log, I don't like have too verbose boot logs. If
you add this, you have a good reason (I hope), but I can't know
it. There's no patch description. So, please give a patch with proper
explanation of why you need that. Anyway, having a proper patch
description is imho always a good idea.

Moreover, there's already good hint if you want to know if you're on to2
or to3. On rev < 3.0, you have this in logs:
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
Turning off NEON support, detected broken NEON implementation

Arnaud
