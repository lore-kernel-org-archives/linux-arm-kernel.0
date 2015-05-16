From: horms@verge.net.au (Simon Horman)
Date: Sat, 16 May 2015 09:10:23 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.2
In-Reply-To: <3987918.TsLFWxo2th@wuerfel>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <3987918.TsLFWxo2th@wuerfel>
Message-ID: <20150516001023.GA11154@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 05:22:23PM +0200, Arnd Bergmann wrote:
> On Thursday 14 May 2015 10:06:56 Simon Horman wrote:
> > Renesas ARM Based SoC DT Updates for v4.2
> > 
> > * Enable DMA for HSUSB on r8a7790 and r8a7791 SoCs
> > * Configure the HOME key as wake-up source on kzm9g board
> > * Use generic names for device nodes on SH Mobile SoCs and boards
> > * Add "nor-jedec" compatible value to SH Mobile boards
> > * Add IRQC clock to r8a73a4, r8a779* SoCs
> > * Remove MSIOF address from r8a7790 and r8a7791 SoCs
> 
> Pulled into next/dt, thanks!
> 
> Please follow-up with a change for the nor-jedec property once that
> discussion has concluded.

Thanks Arnd, will do.
