From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 14:55:32 -0800
Subject: [GIT PULL 4/4] omap device tree changes for v4.5, part 2
In-Reply-To: <56786a00.aa93420a.2d595.ffffdbebSMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1450731519-787330>
 <56786a00.aa93420a.2d595.ffffdbebSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20151222225532.GK30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 01:06:37PM -0800, Tony Lindgren wrote:
> The following changes since commit 89c6f2e5ab7a0499c6bcb25d281977ada205765d:
> 
>   ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi (2015-12-07 16:11:43 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/dt-pt2
> 
> for you to fetch changes up to 6c95771f8c71cd4dd6ed7ab84a3aea7d509d7704:
> 
>   ARM: OMAP2+: LogicPD Torpedo: Add Touchscreen Support (2015-12-21 11:10:40 -0800)
> 
> ----------------------------------------------------------------
> Second set of omap device tree changes for v4.5 merge window. This series
> updates the EDMA bindings based on the various fixes to split EDMA into
> separate independent devices. It also adds support for more devices on the
> CompuLab cm-t335 and LogicPD Torpedo boards, and enables the new bindings
> for qspi for am437x and dra7. There are also few dra7 regulator fixes, and
> change of gpoi-key,wakeup to wakeup-source.
> 
> These depend on commit ae0add740cd0 ("dmaengine: edma: DT: Change reserved
> slot array from 16bit to 32bit type") already merged into mainline.

Thanks, merged.


-Olof
