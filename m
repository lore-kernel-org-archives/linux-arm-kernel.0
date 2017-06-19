From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:00:01 -0700
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#1)
In-Reply-To: <87poe35cw2.fsf@free-electrons.com>
References: <87poe35cw2.fsf@free-electrons.com>
Message-ID: <20170619060001.GB13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 17, 2017 at 08:47:25AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt64 for mvebu for v4.13.
> 
> Gregory
> 
> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
> 
>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.13-1
> 
> for you to fetch changes up to f66b2aff46eaf0825dbe1560e28fcb845dd2a215:
> 
>   arm64: dts: marvell: add xmdio nodes for 7k/8k (2017-06-17 08:19:29 +0200)
> 
> ----------------------------------------------------------------
> mvebu dt64 for 4.13 (part 1)
> 
> - Improve the mcbin support (Armada 8040 based board): add sdhci and
>   the second 1G port
> - Improve crypro nodes description on Aramda 7K/8K
> - Use new binding for ap806 clocks
> - Improve mdio nodes and add xmdio on Aramda 7K/8K
> - Add second SGCI node on Armada 37xx
> - Improve the description of the Armada 3720 DB board

Merged, thanks.


-Olof
