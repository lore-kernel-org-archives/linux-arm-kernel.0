From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:02:38 +0200
Subject: [PATCH v3 0/3] Add support for the otm8009a dsi panel
In-Reply-To: <1500297593-30633-1-git-send-email-philippe.cornu@st.com>
References: <1500297593-30633-1-git-send-email-philippe.cornu@st.com>
Message-ID: <20170818140238.GB28143@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 03:19:50PM +0200, Philippe CORNU wrote:
> Version 3:
> - panel-orisetech-otm8009a.c: Remove a FIXME (Andrzej Hajda)
> - panel/Makefile & Kconfig: Alphabetical order (Andrzej Hajda)
> 
> Version 2:
> - panel-orisetech-otm8009a.c: Add Manufacturer Command Set defines,
>   add new macro for handling address shifting, improve reset
>   sequence, use more mipi dcs helpers (Andrzej Hajda)
> - dt-bindings/display/panel/orisetech,otm8009a.txt: Fix reset gpio
>   active level in the example (Andrzej Hajda), Add an "Optional
>   Properties" section (Rob Herring).
> 
> Version 1:
> - Initial commit
> 
> The purpose of this patch is to add support for the Orise Tech
> otm8009a 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode).
> This LCD panel is used in several STM32 boards.
> 
> Philippe CORNU (3):
>   dt-bindings: Add vendor prefix for Orise Technology
>   dt-bindings: display: panel: Add support for Orise Tech otm8009a dsi
>     panel
>   drm/panel: Add support for otm8009a panel driver
> 
>  .../bindings/display/panel/orisetech,otm8009a.txt  |  21 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/gpu/drm/panel/Kconfig                      |   9 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 491 +++++++++++++++++++++
>  5 files changed, 523 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
>  create mode 100755 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c

Series applied to drm-misc-next, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/7ba4cffb/attachment.sig>
