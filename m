From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 14:31:03 +0200
Subject: [GIT PULL] ARM: imx: fixes for 4.1, 3rd round
In-Reply-To: <20150527113952.GF16165@dragon>
References: <20150527113952.GF16165@dragon>
Message-ID: <2775392.lq7WEYFDjf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 19:39:56 Shawn Guo wrote:
> It includes a couple of fixes for i.MX6 GPC code to let the new kernel
> be able to boot with old DTBs:
> 
>  - Booting v4.1-rc kernel with old DTBs will fail with a fat warning
>    (require low-level debug to be seen), due to the adoption of stacked
>    IRQ domain.  The first fix improves the situation by allowing kernel
>    boot up with old DTBs, although suspend/resume still breaks.
> 
>  - Booting new kernel with old DTBs that do not have power-domain info
>    will result in a hang.  The second patch fixes the hang by skipping
>    the kernel power-domain registration if DTB has no power-domain info.
> 

Pulled into fixes, thanks!

	Arnd
