From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jun 2011 17:20:57 +0100
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
Message-ID: <000201cc2141$0e5df050$2b19d0f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

> I'm trying to find a way to do an MMU off / on transition.

You might want to chat with Per Fransson (CC'd) about this since he
posted something similar a while back:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/030470.html

I still believe we need some code along these lines for kexec and some
instances of CPU hotplug (e.g. on Versatile and RealView platforms).

Will
