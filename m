From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Apr 2014 00:27:10 -0700
Subject: [PATCH 00/15] mtd: st_spi_fsm: Align with ST's internal
 development
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140409072710.GF3131@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 04:39:14PM +0000, Lee Jones wrote:
> This patch-set updates ST's FSM SPI-NOR driver with all the internal
> goodness which has happened since the initial (now upstreamed) snapshot
> was taken. It covers just over 6 months worth of internal development
> and bug-fixes. A final whitespace clean-up is also appended to the set
> - to make it look pretty and stuff. :)

I applied the first 6 to l2-mtd.git/spinor. Please rebase the others so
they can apply, and address the DT comment I sent.

Thanks,
Brian
