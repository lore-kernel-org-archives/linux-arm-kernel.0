From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 17:21:21 -0800
Subject: [GIT PULL] Reset controller changes for v4.6
In-Reply-To: <1455874787.13163.7.camel@pengutronix.de>
References: <1455874787.13163.7.camel@pengutronix.de>
Message-ID: <20160225012121.GF29055@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 10:39:47AM +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> this tag adds reset support for Pistachio, makes
> struct reset_control_ops const, and moves the DT
> cell size check into the core.
> 
> best regards
> Philipp
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.6
> 
> for you to fetch changes up to f673ed4d5fdc123b1552525de30741cd8dfde53f:
> 
>   reset: sti: Make reset_control_ops const (2016-02-10 10:53:38 +0100)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.6
> 
> - add support for the imgtec Pistachio SoC reset controller
> - make struct reset_control_ops const
> - move DT cell size check into the core to avoid code duplication
>   in the drivers

Merged, thanks!


-Olof
