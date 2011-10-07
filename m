From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Oct 2011 19:42:46 -0600 (MDT)
Subject: [PATCH v2 6/6] OMAP4: Clock: Correct the name of SLIMBUS interface
	clocks
In-Reply-To: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
References: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1110061941100.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Beno?t

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> Currently the interface clocks for the two SLIMBUS peripherals are
> named slimbus1_fck and slimbus2_fck. Rename these clocks to be
> slimbus1_ick and slimbus2_ick so it is clear that these are
> interface clocks and not functional clocks.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

This one, I don't quite understand.  We should probably be removing these 
MODULEMODE-only clocks from the OMAP4 tree, and using their parent clock 
as the main_clk.  That would be a good cleanup for 3.3...


- Paul
