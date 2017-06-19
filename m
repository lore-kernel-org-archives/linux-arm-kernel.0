From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:51:56 -0700
Subject: [GIT PULL] Renesas ARM Based SoC R-Car SYSC Updates for v4.13
In-Reply-To: <cover.1497619041.git.horms+renesas@verge.net.au>
References: <cover.1497619041.git.horms+renesas@verge.net.au>
Message-ID: <20170619055156.GL7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 03:31:08PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC R-Car SYSC updates for v4.13.
> 
> This has been separated out from the pull request
> "[GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.13"
> due to differing dependencies. It seems cleanest to provide separate
> branchs rather than do a merge to create a common base for a single branch.
> 
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc-for-v4.13
> 
> for you to fetch changes up to 980532a5dda319eeafadc5c590376626ad178f4f:
> 
>   soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON (2017-06-15 21:10:41 +0200)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC R-Car SYSC Updates for v4.13
> 
> Use GENPD_FLAG_ALWAYS_ON in R-Car SYSC driver
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON

Merged, thanks.


-Olof
