From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:05:37 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <20121024200400.GZ21046@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-2-git-send-email-andrew@lunn.ch>
 <20121024213128.2d4c07dc@skate> <50884659.1020208@gmail.com>
 <20121024220021.148a88ff@skate> <20121024200400.GZ21046@lunn.ch>
Message-ID: <20121024220537.130573e2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 22:04:00 +0200, Andrew Lunn wrote:

> > is needlessly repeated in kirkwood-ts219-6281.dts,
> > kirkwood-ts219-6282.dts and kirkwood-dnskw.dtsi. This is clearly a
> > pinmux configuration that sets up TXD/RXD of UART1, and it should be in
> > kirkwood.dtsi.
> 
> I did try that, but was getting errors from dtc.

I can probably help figuring out what the problem is. Do you have a
patch that exhibits the problem so I can test it here?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
