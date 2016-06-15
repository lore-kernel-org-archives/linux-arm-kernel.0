From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 15 Jun 2016 15:12:29 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Ethernet Switch drivers
In-Reply-To: <1466026874-11971-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Wed, 15 Jun 2016 23:41:14 +0200")
References: <1466026874-11971-1-git-send-email-andrew@lunn.ch>
Message-ID: <m24m8unlte.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

> Kernelci now has two boards with Ethernet switches supported by DSA.
> Enable DSA and the switch drivers so we get some boot testing.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Any reason these can't be modules?

The default initramfs for kernelci will automatically load modules.

Kevin
