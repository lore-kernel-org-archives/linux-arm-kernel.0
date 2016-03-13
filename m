From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:37:35 -0800
Subject: Reset controller changes for v4.6: shared resets
In-Reply-To: <1457424755.4174.12.camel@pengutronix.de>
References: <1457424755.4174.12.camel@pengutronix.de>
Message-ID: <20160313013735.GE5883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 09:12:35AM +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> this tag adds reference counted shared reset support for multiple
> consumers that use the same reset line for low power states.
> Also there is a cleanup patch for lpc18xx removing global variables.
> 
> regards
> Philipp
> 
> The following changes since commit f673ed4d5fdc123b1552525de30741cd8dfde53f:
> 
>   reset: sti: Make reset_control_ops const (2016-02-10 10:53:38 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.6-2
> 
> for you to fetch changes up to bc2a505c3f325c1b4ce0610fbeee3000910fda61:
> 
>   reset: Add support for shared reset controls (2016-02-24 11:37:32 +0100)

Hi Philipp,

Timing is late for new development like this, unfortunately. I would
prefer to wait until next merge window on this material.

Would you mind resending this after -rc1?


Thanks,


-Olof
