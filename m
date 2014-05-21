From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 15:03:59 +0300
Subject: [PATCH v2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
References: <1400663706-24104-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <537C962F.6050104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/14 12:15, Florian Vaussard wrote:
> Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
> board.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
> v1->v2:
> - Rebased on Tony's omap-for-v3.16/dt-v2
> - Use OMAP4_IOPAD macro
> - Use hpd pin as GPIO with hdmi-connector
> 
>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Looks good to me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/3c73382e/attachment.sig>
