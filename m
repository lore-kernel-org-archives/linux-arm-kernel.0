From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Feb 2018 10:13:59 +0100
Subject: [PATCH v2 0/5] Add R8A77980/Condor board support
In-Reply-To: <ae31804b-969b-9b20-16d0-50f5dea42f08@cogentembedded.com>
References: <ae31804b-969b-9b20-16d0-50f5dea42f08@cogentembedded.com>
Message-ID: <20180219091359.satlh3tmdftre6mt@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 09:25:30PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-20180216-v4.16-rc1' tag. I'm adding the device tree support
> for the R8A77980-based Condor board (note that NFS root would only work on
> the Condor boards [re]wired for booting from EtherAVB -- we haven't been
> able to get the 'sh_eth' driver working in either U-Boot or Linux so far).
> The necessary SYS-DMAC, [H]SCIF, and EtherAVB bindings updates have been
> posted, the clock driver has been reposted yesterday, and the merged patches
> have been dropped from this respin of the series...
> 
> [1/5] soc: renesas: rcar-sysc: add R8A77980 support
> [2/5] arm64: dts: renesas: r8a77980: add [H]SCIF support
> [3/5] arm64: dts: renesas: r8a77980: add EtherAVB support
> [4/5] arm64: dts: renesas: initial Condor board device tree
> [5/5] arm64: dts: renesas: condor: add EtherAVB support

Thanks, applied.
