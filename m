From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 6 Jan 2013 09:35:21 +0100
Subject: Reboot hangs on Kirkwood ns2 boards with 3.8-rc2
In-Reply-To: <20130106033455.GH1357@kw.sim.vm.gnt>
References: <20130106033455.GH1357@kw.sim.vm.gnt>
Message-ID: <20130106083521.GO17242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 04:34:55AM +0100, Simon Guinot wrote:
> Hi Andrew and Jason,
> 
> While testing 3.8-rc2 on the ns2 boards (DT based), I noticed that
> reboot is not working. After issuing a reboot, the kernel hangs. No
> error messages are displayed. Moreover, on my non-DT Kirkwood boards,
> reboot is working as expected.
> 
> Am I the only one to experiment this issue ?

Hi Simon

No you are not the only one. There is a patch available, authored by
me, which is identical to what you found.

We have been a bit slow recently pushing fixes into 3.8-rc, vacations,
etc. I plan to spend some time today collecting the fixes together and
sending them upstream.

	Andrew
