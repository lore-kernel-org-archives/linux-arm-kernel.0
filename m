From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Oct 2013 22:24:56 +0200
Subject: [PATCH v2 1/2] ARM: kirkwood: retain MAC address for DT ethernet
In-Reply-To: <20131003194449.GB30298@obsidianresearch.com>
References: <1380804294-13726-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1380826568-18587-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131003190201.GA2504@localhost>
 <20131003190437.GY31178@titan.lakedaemon.net>
 <20131003194449.GB30298@obsidianresearch.com>
Message-ID: <20131003202456.GH20056@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sebastian, does __clk_enabled work properly for the mvebu clock
> provider? I don't see a clk_ops.is_enabled for mvebu.. (don't know
> much about clk)

Hi Jason

It is implemented in drivers/clk/clk-gate.c, which is what mvebu is
using.

   Andrew
