From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Mar 2015 11:57:22 +0100
Subject: [PATCH 1/2] drm/panel: simple: Add support for Shelly
 SCA07010-BFN-LNN
In-Reply-To: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
References: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
Message-ID: <20150324105721.GH18115@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 02:43:00PM +0100, Nicolas Ferre wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> The Shelly SCA07010-BFN-LNN is a 7.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 7" LCD screen (TM70xx series for
> instance).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../bindings/panel/shelly,sca07010-bfn-lnn.txt     |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/panel/shelly,sca07010-bfn-lnn.txt

The vendor prefix "shelly" doesn't seem to be documented yet. Can you
submit a patch to fix that?

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/48e92ded/attachment.sig>
