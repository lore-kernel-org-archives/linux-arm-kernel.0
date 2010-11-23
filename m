From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Nov 2010 19:29:44 -0500 (EST)
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <AANLkTikEs8nLPnLuWb67jH9CAMOAJhB_T7C9ZDpc6d+7@mail.gmail.com>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221346170.9313@xanadu.home>
	<20101122191719.GO31227@n2100.arm.linux.org.uk>
	<AANLkTikEs8nLPnLuWb67jH9CAMOAJhB_T7C9ZDpc6d+7@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011221927140.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

> On Mon, Nov 22, 2010 at 7:17 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > With CPU hotplug, as it is called from the hotplug CPU 
> > initialization path, it needs to be available for that path to call.
> >
> > So it can't be thrown away with the init code when hotplug is enabled.
> 
> I will infer from this that the patch is useful/correct in its current state...

Right.


Nicolas
