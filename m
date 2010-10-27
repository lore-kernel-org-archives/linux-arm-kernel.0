From: tbm@cyrius.com (Martin Michlmayr)
Date: Wed, 27 Oct 2010 15:40:25 +0100
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
In-Reply-To: <alpine.LFD.2.00.1010270856370.27159@xanadu.home>
References: <20101019190533.GA11893@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010191529100.2764@xanadu.home>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B415F@IL-MB01.marvell.com>
	<alpine.LFD.2.00.1010211608550.2764@xanadu.home>
	<20101025151210.GV16863@jirafa.cyrius.com>
	<20101027111656.GA11417@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010270856370.27159@xanadu.home>
Message-ID: <20101027144024.GC10830@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [2010-10-27 08:57]:
> > A Debian user has confirmed in the meantime that the patch helps on
> > the TS-419P.
> 
> Helped what, exactly?

The SATA problems on TS-419P are gone, i.e. this confirms 2) of your
"Can I have confirmation that 1) new breakages are gone, and 2) the
device where this reset did fix problems are still OK with this
change?"

-- 
Martin Michlmayr
http://www.cyrius.com/
