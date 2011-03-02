From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 02 Mar 2011 20:35:16 +0100
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	(Dinh Nguyen's message of "Wed, 2 Mar 2011 11:17:58 -0600")
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <8762s1xqmj.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<Dinh.Nguyen@freescale.com> writes:

Hi,

> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>
> Adds initial low power suspend functionality to MX51.
> Supports "mem" and "standby" modes.

I've very quickly tried suspend to mem on my system and despite having set
some irq as wakeup source, it doesn't wake up. Is there some extra step
to be done in order to test your patch ?

Moreover, the code I've seen for suspend is very different. It's seems
to handle some cpufreq stuff and seems to be copying some code into some
special ram. Is all this stuff unneeded ?

Arnaud
