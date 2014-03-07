From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Mar 2014 11:05:26 +0900
Subject: [PATCH 00/03] ARM: shmobile: Break out and extend clock workaround
In-Reply-To: <20140224072921.3522.55023.sendpatchset@w520>
References: <20140224072921.3522.55023.sendpatchset@w520>
Message-ID: <20140307020521.GF11702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 04:29:21PM +0900, Magnus Damm wrote:
> ARM: shmobile: Break out and extend clock workaround
> 
> [PATCH 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
> [PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on Lager
> [PATCH 03/03] ARM: shmobile: Use shmobile_clk_workaround() on Koelsch
> 
> These patches consolidates the clkdev workaround present in the DT
> reference version of board code for Lager and Koelsch, and it also
> extends it to allow static enablement of a selected set of clocks
> during boot. The latter is needed for USB PCI support patches that
> will be posted shortly.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued these up.
