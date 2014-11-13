From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 16:28:54 +0200
Subject: [PATCH v3 1/4] dt-bindings: simplefb: Specify node location and
 handoff related properties
In-Reply-To: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
Message-ID: <5464C026.7030300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 15:34, Hans de Goede wrote:

> +chosen {
> +	framebuffer0: framebuffer at 5fc00000 {
>  		compatible = "simple-framebuffer";
> -		reg = <0x1d385000 (1600 * 1200 * 2)>;
> +		reg = <0x5fc00000 (4096 * 1024)>;

Was there a reason for this change? The former version seems much more
obvious to me, especially as this is an example.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/8460e95f/attachment.sig>
