From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Jun 2014 23:49:37 +0200
Subject: [PATCH v14 08/10] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <1402913484-25910-8-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-8-git-send-email-denis@eukrea.com>
Message-ID: <20140624214926.GA30039@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 12:11:22PM +0200, Denis Carikli wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt
[...]
> @@ -0,0 +1,7 @@
> +Eukrea DVI-SVGA (800x600 pixels) DVI output.
[...]
> diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt
[...]
> @@ -0,0 +1,7 @@
> +Eukrea DVI-VGA (640x480 pixels) DVI output.

DVI outputs shouldn't be using the panel framework and this binding at
all. DVI usually has the means to determine all of this by itself. Why
do you need to represent this as a panel in device tree?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/6168382a/attachment-0001.sig>
