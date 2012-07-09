From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 09 Jul 2012 14:19:33 +0200
Subject: [PATCH 0/7] arm/dts: Audio support for OMAP4 devices (SDP,
 PandaBoard)
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <4FFACC55.4060106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 06/08/2012 04:01 PM, Peter Ujfalusi wrote:
> Hello,
> 
> The following series enable the audio functionality on OMAP4 based devices using
> twl6040 as audio codec.
> 
> The series adds the needed bindings in the dts for the OMAP IPs, twl6040 MFD
> device and for the audio connection on the board.
> 
> To be able to differentiate between PandaBoard and PandaBoardES (they have a bit
> different audio configuration) a new dts file has been created which only
> changes the audio properties different between the two boards.
> 
> Patches for the drivers involved and the documentation related to dts sections
> has been either in 3.5 or heading for 3.6.

Probably this series has been overlooked, since I have not received feedback
on it.
Should I resend the series? Which tree should I use to rebase it?

Thank you,
P?ter

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   arm/dts: omap4: Add entry for OMAP McPDM IP
>   arm/dts: omap4: Add entry for OMAP DMIC IP
>   arm/dts: omap4-sdp: Add fixed regulator to represent VBAT
>   arm/dts: omap4-sdp: Add support for twl6040
>   arm/dts: omap4-sdp: Enable audio support via device tree
>   arm/dts: omap4-panda: Audio support for PandaBoard 4430
>   arm/dts: New dts file for PandaBoardES (4460)
> 
>  arch/arm/boot/dts/omap4-panda.dts   |   37 +++++++++++++++++++
>  arch/arm/boot/dts/omap4-pandaES.dts |   24 ++++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts     |   68 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi        |   18 +++++++++
>  4 files changed, 147 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap4-pandaES.dts
> 
