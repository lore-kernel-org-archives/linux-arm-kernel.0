From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Feb 2016 13:59:03 -0800
Subject: [GIT PULL] ARM: mvebu: dt for v4.6 (#1)
In-Reply-To: <8737t32saq.fsf@free-electrons.com>
References: <8737t32saq.fsf@free-electrons.com>
Message-ID: <20160208215903.GO25468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 08, 2016 at 03:25:01PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt for mvebu for v4.6.
> This one is based on v4.5-rc3 because it depends on fixes merged
> previously.
> 
> Gregory
> 
> The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:
> 
>   Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.6-1
> 
> for you to fetch changes up to ebe1adff92de94f1ec48a46d9afa74ba967674dc:
> 
>   ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl (2016-02-08 09:39:41 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt for 4.6 (part 1)
> 
> - Improve Armada 388 device tree (SATA and XHCI)
> - Fix SD Card and audio support for OpenRD board
> - Provide template for RS-232/485 configuration for the same board
> - Use a common dtsi file for linkstation boards
> - Add support for Buffalo Linkstation LS-QVL
> 
> ----------------------------------------------------------------
> Aaro Koskinen (4):
>       ARM: DTS: kirkwood-openrd: fix pin names for UART/SD selection
>       ARM: DTS: kirkwood-openrd: fix SD slot default configuration
>       ARM: DTS: kirkwood-openrd: provide template for RS-232/485 configuration
>       ARM: DTS: kirkwood-openrd-client: fix audio
> 
> Gregory CLEMENT (2):
>       ARM: mvebu: use usb-nop-xceiv PHY for the xhci nodes on Armada 388 GP
>       ARM: mvebu: Update the mpp63 function in the device tree on Armada 370
> 
> Mario Lange (1):
>       ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl
> 
> Roger Shimizu (3):
>       ARM: dts: kirkwood: relicense dts of ls-wvl/vl and ls-wxl/wsxl under GPLv2/X11
>       ARM: dts: kirkwood: split lswxl dts to linkstation lswsxl and lswxl
>       ARM: dts: kirkwood: split lswvl dts to linkstation lsvl and lswvl
> 
> Thomas Petazzoni (2):
>       ARM: mvebu: adjust board name and compatible for Armada 388 GP
>       ARM: mvebu: use regulator-boot-on for SATA regulators on Armada 388 GP

You're using three different kind of ways to label the patches here, please use
the common one that we try to keep consistent across platforms:

ARM: dts: <platform>:...

Can you fixup and send a fresh pull request, please?


Thanks!


-Olof
