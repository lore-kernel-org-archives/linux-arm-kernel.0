From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Apr 2014 17:59:49 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140413175658.64b65a76@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413154715.GE10033@lunn.ch> <20140413175658.64b65a76@skate>
Message-ID: <20140413155949.GG10033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> To be honest, I find it pretty useless to have half of the Kirkwood
> and Dove support in mach-mvebu, and half still in
> mach-kirkwood/mach-dove, because it doesn't allow to remove any of the
> legacy code in mach-kirkwood and mach-dove. But oh, well, I guess it's
> only a temporary situation, until more boards are converted, or their
> support simply removed.

I hope kirkwood will complete its move soon. I have Openrd in a state
it can move to mvebu, So that only leaves netxbig_v2.c.

   Andrew
