From: tbm@cyrius.com (Martin Michlmayr)
Date: Mon, 25 Oct 2010 16:12:10 +0100
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
In-Reply-To: <alpine.LFD.2.00.1010211608550.2764@xanadu.home>
References: <20101019190533.GA11893@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010191529100.2764@xanadu.home>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B415F@IL-MB01.marvell.com>
	<alpine.LFD.2.00.1010211608550.2764@xanadu.home>
Message-ID: <20101025151210.GV16863@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [2010-10-21 16:25]:
> Can I have confirmation that 1) new breakages are gone, and 2) the
> device where this reset did fix problems are still OK with this change?

I can confirm 1) on my QNAP TS-209.  I also booted a kernel with the
patch on my TS-419P but I never had a reliable way to trigger the
issue.  Maybe Olaf or Bernhard can help with this.
-- 
Martin Michlmayr
http://www.cyrius.com/
