From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 12 Jan 2015 11:41:06 +0100
Subject: [PATCH RESEND 0/4] Small updates to Snow and Peach Pit/Pi DTS
In-Reply-To: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54B3A4C2.8070304@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 01/02/2015 04:24 PM, Javier Martinez Canillas wrote:
> 
> This series adds some DTS snippets that were missing in the mainline
> Snow and Peach Pit/Pi Device Trees but are present in the downstream
> ChromeOS kernel.
> 
> The series is composed of the following patches:
> 
> Javier Martinez Canillas (4):
>   ARM: dts: Add power and lid GPIO keys pinctrl for exynos5250-snow
>   ARM: dts: Add lid GPIO key device node for Peach boards
>   ARM: dts: Set Peach boards USB WebCam regulators to always on
>   ARM: dts: Configure regulators for suspend on exynos Peach boards
> 
>  arch/arm/boot/dts/exynos5250-snow.dts      |  16 +++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 100 +++++++++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 101 ++++++++++++++++++++++++++++-
>  3 files changed, 215 insertions(+), 2 deletions(-)
> 
> Patch #1 adds some pinctrl lines for the GPIO keys in the Snow DTS.
> 
> Patch #2 adds a device node and pinctrl lines for the lid GPIO in
> the Peach boards DTS.
> 
> Patch #3 sets the regulators that supply voltage to the USB WebCam
> in Peach boards as always on.
> 
> Patch #4 configures the max77802 regulators on the Peach Pit and Pi
> boards to be enabled or disabled during system suspend.
> 

I saw that you collected some DTS patches for 3.20 but these are not
included. Any comments about this series?

Thanks a lot and best regards,
Javier
