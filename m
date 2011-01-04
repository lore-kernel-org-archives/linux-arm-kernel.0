From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 09:37:15 -0500 (EST)
Subject: [PATCH 0/4] variable PHYS_OFFSET support
In-Reply-To: <20110104104112.GB16671@n2100.arm.linux.org.uk>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<20110104104112.GB16671@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101040935220.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> So, I don't think it's ready for this coming merge window.

OK, agreed.

We could also take the time to make the kdump kernel benefit from this 
feature at the same time, removing the need from a special build of the 
kernel for this purpose, which would be a direct application.


Nicolas
