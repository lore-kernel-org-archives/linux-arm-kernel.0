From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 11:13:37 +0200
Subject: [PATCH v8 3/3] ARM: sunxi: Add IR controller support in DT on A20
In-Reply-To: <1401056805-2218-4-git-send-email-bay@hackerdom.ru>
References: <1401056805-2218-1-git-send-email-bay@hackerdom.ru>
 <1401056805-2218-4-git-send-email-bay@hackerdom.ru>
Message-ID: <20140527091337.GJ4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 04:26:45AM +0600, Alexander Bersenev wrote:
> This patch adds IR controller in A20 Device-Tree:
> - Two IR devices found in A20 user manual
> - Pins for two devices
> - One IR device physically found on Cubieboard 2
> - One IR device physically found on Cubietruck
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts  |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi            | 32 +++++++++++++++++++++++++++++

I told you numerous times already that I wanted this patch to be split
into at least three of them:
  - One to add the device to the DTSI.
  - One to add the pins
  - and one to enable the devices in the DTS.

Please address this comment.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/77793e0e/attachment.sig>
