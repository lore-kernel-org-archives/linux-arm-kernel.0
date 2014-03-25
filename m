From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Mar 2014 11:36:33 +0100
Subject: [PATCH 00/10] ARM: mvebu: Hardware coherency support for Armada
 375 and 38x
In-Reply-To: <20140325093232.GH14983@lunn.ch>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140324160620.607c77cd@skate> <20140325093232.GH14983@lunn.ch>
Message-ID: <20140325113633.6b7d13e5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 25 Mar 2014 10:32:32 +0100, Andrew Lunn wrote:

> I took a look at them. The XOR code is interesting. I guess it is not
> good for performance. A loud debug message would be useful to know
> when the workaround has been turned on.

I haven't measured the performance impact, but indeed I suspect there
is one. I'm fine with printing a warning.

> Once you send a rebase on 3.15 i can send an ACK.

Great, thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
