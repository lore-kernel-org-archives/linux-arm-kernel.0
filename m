From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Oct 2015 01:19:36 +0200
Subject: [PATCH 0/9] Further mvebu PCIe patches
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
Message-ID: <20151008231936.GA14688@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2015 at 07:12:28PM +0100, Russell King - ARM Linux wrote:
> Jason, Thomas,
> 
> Here are further PCIe patches which follow on from the previous set of
> six I sent earlier in September.  This set:

Hi Russell

Tested on my Kirkwood based DLINK DIR665 with a topdog wireless lan
card. This does not make use of the GPIO reset, so those parts of the
patch are untested. But otherwise, no obvious regressions, i can join
the wireless LAN etc.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	   Andrew
