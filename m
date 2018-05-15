From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:49:38 -0700
Subject: [GIT PULL] Reset controller changes for v4.18
In-Reply-To: <1526374427.2303.3.camel@pengutronix.de>
References: <1526374427.2303.3.camel@pengutronix.de>
Message-ID: <20180515204938.zepjxpsf5whvbujw@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 10:53:47AM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> The following changes since commit e6914365fd280fce303a89b8a8d4529af5a2e0f9:
> 
>   reset: uniphier: fix USB clock line for LD20 (2018-04-27 11:51:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.pengutronix.de/pza/linux.git tags/reset-for-4.18
> 
> for you to fetch changes up to d7bab65b1f57cdf2d81fc469cea6b2160a50e917:
> 
>   reset: uniphier: add LD11/LD20 stream demux system reset control (2018-04-27 11:59:05 +0200)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.18
> 
> This adds PCIe, SATA, and HSC reset control support on various Uniphier
> SoCs. PCIe reset control is added for Pro5, LD20, and PXs3 SoCs, SATA
> reset control support is added on Pro4 and PXs3 SoCs. The previously
> added PXs2 SATA reset control identifier is changed to the same value
> for consistency. HSC (MPEG2 transport stream I/O and demux system) reset
> controls are added for LD11 and LD20 SoCs.

Merged, thanks!


-Olof
