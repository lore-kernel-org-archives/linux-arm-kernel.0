From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 24 Jun 2014 23:56:39 +0200
Subject: [PATCH v14 08/10] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <20140624214926.GA30039@mithrandir>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-8-git-send-email-denis@eukrea.com>
 <20140624214926.GA30039@mithrandir>
Message-ID: <20140624235639.487429ad@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Le Tue, 24 Jun 2014 23:49:37 +0200,
Thierry Reding <thierry.reding@gmail.com> a ?crit :

> On Mon, Jun 16, 2014 at 12:11:22PM +0200, Denis Carikli wrote:
> [...]
> > diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt
> [...]
> > @@ -0,0 +1,7 @@
> > +Eukrea DVI-SVGA (800x600 pixels) DVI output.
> [...]
> > diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt
> [...]
> > @@ -0,0 +1,7 @@
> > +Eukrea DVI-VGA (640x480 pixels) DVI output.
> 
> DVI outputs shouldn't be using the panel framework and this binding at
> all. DVI usually has the means to determine all of this by itself. Why
> do you need to represent this as a panel in device tree?
> 
because on this very simple display board, we only have DVI LVDS signals
without the I2C to detect the display.

Best regards
Eric
