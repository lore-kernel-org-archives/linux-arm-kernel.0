From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 16 Jun 2016 00:22:12 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Ethernet Switch drivers
In-Reply-To: <m24m8unlte.fsf@baylibre.com>
References: <1466026874-11971-1-git-send-email-andrew@lunn.ch>
 <m24m8unlte.fsf@baylibre.com>
Message-ID: <20160615222212.GH5841@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 03:12:29PM -0700, Kevin Hilman wrote:
> Hi Andrew,
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > Kernelci now has two boards with Ethernet switches supported by DSA.
> > Enable DSA and the switch drivers so we get some boot testing.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Any reason these can't be modules?

Nodules should work, not that i test it very often.

I will respin as modules.

  Andrew
