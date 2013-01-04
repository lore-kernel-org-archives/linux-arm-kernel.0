From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Jan 2013 18:31:39 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <50E710CB.8070007@lunn.ch>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch>
Message-ID: <20130104183139.20492204@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 04 Jan 2013 18:26:35 +0100, Andrew Lunn wrote:

> How many different boards have you tried?

I've tried only one board, since I have only one.

> I've not had problems with the board i have. Using the plathome supplied 
> kernel, i've rebuilt the kernel, which is a good memory test. Using 
> mainline, i've booted a number of times when developing the thermal 
> driver and not had problems.
> 
> I would hate to disable 2GB of RAM just because your board has a fault.

Indeed. If you report that things work nicely on your board, then let's
discard this fix, and blame a hardware problem.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
