From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 08:48:09 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Mark EthernetAVB device nodes
 disabled
In-Reply-To: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
References: <1485350371-16091-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170126074806.GE12042@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 02:19:29PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series marks the EthernetAVB device nodes in the R-Car H3 and
> M3-W DTSes disabled.
> Device nodes representing I/O devices should be marked disabled in the
> SoC-specific DTSes, and overridden by board-specific DTSes where needed.
> 
> Thanks for applying!

Thanks,

as these are fixes I have queued them up for v4.11.
