From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Apr 2014 19:57:46 +0800
Subject: [PATCH v2][ 2/3] ARM: dts: mbimxsd51 baseboard: Add USB support.
In-Reply-To: <1396886641-26985-2-git-send-email-denis@eukrea.com>
References: <1396886641-26985-1-git-send-email-denis@eukrea.com>
 <1396886641-26985-2-git-send-email-denis@eukrea.com>
Message-ID: <20140408115745.GD3860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 06:04:00PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - This patch has been splitted out of my previous imx25/35/51 USB patchset.
>   It's made from the "ARM: dts: i.MX51: Add a second usbphy." and the
>   "ARM: dts: mbimxsd51 baseboard: Add USB host support" patchset.
>   - USB OTG support was added.
>   - The second USB phy was moved outside of imx51.dtsi
>   - "phy_type = "ulpi";" was added to the usbh1 node, like with the imx51 babbage.
>   - Now depends on the "chipidea: usbmisc_imx: Allow USB OTG to work on mx51" patch
>     which is queued by Peter Chen.
> ---
>  .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)

Applied, thanks.
