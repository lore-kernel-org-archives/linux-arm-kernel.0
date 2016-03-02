From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 2 Mar 2016 17:12:36 +0100
Subject: [PATCH v2 2/2] drm/panel: Support for LG lp120up1 panel with eDP
 input
In-Reply-To: <1456138904-15258-2-git-send-email-jitao.shi@mediatek.com>
References: <1456138904-15258-1-git-send-email-jitao.shi@mediatek.com>
 <1456138904-15258-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <20160302161236.GC23204@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 07:01:44PM +0800, Jitao Shi wrote:
> The LG lp120up1 TFT LCD panel with eDP interface is a 12.0" 1920x1280
> panel, which can be supported by the simple panel driver
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Changes since v1:
>  - Add eDP panel type in comment msg
>  - Fixed comment msg with 72 characters width
> ---
>  drivers/gpu/drm/panel/panel-simple.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160302/9b3f9772/attachment.sig>
