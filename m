From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Feb 2018 14:28:34 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Update OPPs to support CA53 dfs
In-Reply-To: <20180129182121.833-1-horms+renesas@verge.net.au>
References: <20180129182121.833-1-horms+renesas@verge.net.au>
Message-ID: <20180219132834.suxvodokl4vzdzqj@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 07:21:19PM +0100, Simon Horman wrote:
> Describe frequencies, other than the default for CA53 cores.  This is a
> pre-requisite for using providing alternative frequencies for use with
> CPUFreq with these cores.
> 
> CPUFreq requires Z and Z2 clock support to function.
> That this patchset and that dependency can be found at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq-v5
> 
> Dien Pham (2):
>   arm64: dts: r8a7796: Update OPPs to support CA53 dfs
>   arm64: dts: r8a7795: Update OPPs to support CA53 dfs

Applied for v4.17.
