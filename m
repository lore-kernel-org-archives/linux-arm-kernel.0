From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 12 Mar 2018 09:51:20 +0100
Subject: [PATCH v3 4/7] drm/panel: simple: Add support for KEO
 TX31D200VM0BAA
In-Reply-To: <1517766571-409-5-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
 <1517766571-409-5-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180312085120.GI23060@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 04, 2018 at 11:19:28PM +0530, Jagan Teki wrote:
> This adds support for the Kaohsiung Opto-Electronics.,
> TX31D200VM0BAA 12.3" HSXGA LVDS panel, which can be
> supported by the simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v3:
> - collect Rob reiew tag 
> Changes for v2:
> - Updated binding info about optional properties, node and example
> 
>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 ++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt

The koe vendor prefix is undocumented, please send a patch to add it to
Documentation/devicetree/bindings/vendor-prefixes.txt.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/e15f7917/attachment.sig>
