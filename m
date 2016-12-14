From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 Dec 2016 11:54:28 +0200
Subject: [PATCH v7 4/5] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <1481623759-12786-5-git-send-email-bgolaszewski@baylibre.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <0ad07b84-7f5a-6467-e310-52c3efc66d3d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 12:09, Bartosz Golaszewski wrote:
> Add the vga-bridge node to the board DT together with corresponding
> ports and vga connector. This allows to retrieve the edid info from
> the display automatically.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/d7838da1/attachment.sig>
