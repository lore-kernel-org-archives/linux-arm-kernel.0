From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Mar 2015 11:58:17 +0100
Subject: [PATCH 2/2] drm/panel: simple: Add support for Innolux AT043TN24
In-Reply-To: <84ca8ea51cd7bd709729de927d60d8a2f47664c7.1426772560.git.nicolas.ferre@atmel.com>
References: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
 <84ca8ea51cd7bd709729de927d60d8a2f47664c7.1426772560.git.nicolas.ferre@atmel.com>
Message-ID: <20150324105816.GI18115@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 02:43:01PM +0100, Nicolas Ferre wrote:
> The Innolux AT043TN24 4.3" WQVGA TFT LCD panel.
> This panel with backlight is found in PDA 4.3" LCD screen (TM43xx series for
> instance).
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../bindings/panel/innolux,at043tn24.txt           |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/panel/innolux,at043tn24.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/575c8ec0/attachment.sig>
