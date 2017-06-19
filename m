From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:07:41 -0700
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.13
In-Reply-To: <1497801323-6389-3-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
 <1497801323-6389-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170619060741.GF13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 18, 2017 at 11:55:21PM +0800, Shawn Guo wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.13
> 
> for you to fetch changes up to d8710c3fb912574709166bba24f4c64162ab832c:
> 
>   ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes (2017-06-17 21:17:04 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree updates for 4.13:
>  - New board support: Gateworks Ventana GW5600, Technexion Pico i.MX7D
>    Board.
>  - A series from Alexandre Belloni to correct the vendor prefix for
>    rv4162 compatible.
>  - A patch-set from Andrey Smirnov ot enable PCIe support for i.MX7 and
>    imx7d-sdb board.
>  - Increase the SGTL5000 LRCLK pad strength to fix a random audio
>    channel swapping seen on imx6qdl-wandboard and imx6qdl-colibri
>    boards.
>  - Clean up non-existing property 'enable-active-low' from fixed
>    regulator device nodes.
>  - Correct GPIO polarity for Ethernet PHY and PCI reset lines, even
>    though device drivers do not use the polarity for now.
>  - Add Wifi and Bluetooth support for imx7d-sdb board.
>  - Adopt the i.MX6Q/DL DT to the new and more flexible GPC binding.
>  - Update zii-rdu2 device tree source to use #include "..." for local
>    inclusion.
>  - A series from Philipp Zabel and Steve Longerbeam to enable video
>    capture support for imx6qdl platforms.
>  - A number of small random updates on various board support.

Merged, thanks!


-Olof
