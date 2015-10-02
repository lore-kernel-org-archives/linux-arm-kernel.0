From: scottwood@freescale.com (Scott Wood)
Date: Thu, 1 Oct 2015 19:26:29 -0500
Subject: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
In-Reply-To: <20150811182535.31346.52965@quantum>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <20150811182535.31346.52965@quantum>
Message-ID: <1443745589.5336.185.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resending to updated e-mail address]

On Tue, 2015-08-11 at 11:25 -0700, Michael Turquette wrote:
> Hi Scott,
> 
> Quoting Scott Wood (2015-06-18 19:49:10)
> > The existing device tree bindings are error-prone and inflexible. 
> > Correct the mistake by moving the knowledge into the driver, which
> > has more flexibility in describing the quirks of each chip.  This leaves
> > the device tree to its proper role of identifying a programming interface
> > rather than describing its individual registers.
> 
> Sorry for not responding to this one sooner. Fell through the cracks.
> 
> All of the changes to drives/clk/clk-qoriq.c look great to me. I assume
> you need to keep all of these patches together and want to the take
> through the freescale tree? If so feel free to add,
> 
> Acked-by: Michael Turquette <mturquette@baylibre.com>

Is the ack still valid for the v3 patchset?

-Scott
