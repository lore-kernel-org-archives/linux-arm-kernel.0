From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Jun 2017 20:19:34 +0200
Subject: [PATCH v3 0/3] Add support for the S6E3HF2 panel on TM2e board
In-Reply-To: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170418084047epcas5p493261a4cb9204e682f60cde8d659565c@epcas5p4.samsung.com>
 <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170614181934.GF14971@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:40:33PM +0900, Hoegeun Kwon wrote:
> Hi all,
> 
> The purpose of this patch is add support for s6e3hf2 AMOLED panel on
> the TM2e board. The panel has 1600x2560 resolution in 5.65" physical
> panel in the TM2e device.
> 
> The s6e3hf2 panel(5.65") is simliar to the previous s6e3ha2 panel(5.7"),
> but resolution and some command message are different. So it can be
> distinguished as a compatiblitiy string.
> 
> Best regards,
> Hoegeun
> 
> Changes for V3:
> - Remove te-gpios property in dts.
> - Added Reviewed-by: Andrzej Hajda <a.hajda@samsung.com> on all patches.
> - Added Reviewed-by: Inki Dae <inki.dae@samsung.com> on patch (2/3).
> 
> Changes for V2:
> - Add new compatible string to "samsung,s6e3ha2.txt binding with comments.
> - Fix the panel name from s6e3ha2-e to s6e3hf2
> 
> Hoegeun Kwon (3):
>   dt-bindings: Add support for samsung s6e3hf2 panel
>   drm/panel: s6e3ha2: Add support for s6e3hf2 panel on TM2e board
>   arm64: dts: exynos: Add support for s6e3hf2 panel device on TM2e board
> 
>  .../bindings/display/panel/samsung,s6e3ha2.txt     |  5 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 11 ++++
>  drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 64 +++++++++++++++++++---
>  3 files changed, 72 insertions(+), 8 deletions(-)

Applied patches 1/3 and 2/3 to drm-misc-next, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/b8cfc7ab/attachment.sig>
