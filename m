From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 11:01:12 +0900
Subject: [PATCH] ARM: shmobile: Select IRQC in case of the r8a7791 SoC
In-Reply-To: <20131008031608.10122.53864.sendpatchset@w520>
References: <20131008031608.10122.53864.sendpatchset@w520>
Message-ID: <20131009020111.GA15065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 12:16:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r8a7791 contains IRQC hardware so make sure
> the driver gets built by selecting RENESAS_IRQC.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
