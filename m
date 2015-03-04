From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 4 Mar 2015 23:17:29 +0100
Subject: [PATCH] genirq: describe IRQF_COND_SUSPEND
In-Reply-To: <20150304200040.GA12126@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150304194246.GF22156@leverpostej>
 <20150304200040.GA12126@leverpostej>
Message-ID: <20150304221729.GI3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tiny tiny nitpick:

On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> With certain restrictions it is possible for a wakeup device to share
> and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
  ^ an


> +In rare cases an IRQ can be shared between a wakeup device driver and an
> +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> +must be able to discern spurious IRQs from genuine wakeup events (signalling

And genuine question, should we use British English or American English
or we don't care ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
